Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262211AbSJOAjV>; Mon, 14 Oct 2002 20:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSJOAjV>; Mon, 14 Oct 2002 20:39:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:53432 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262211AbSJOAjV>; Mon, 14 Oct 2002 20:39:21 -0400
Date: Mon, 14 Oct 2002 17:43:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <2005946728.1034617377@[10.10.2.3]>
In-Reply-To: <3DAB6385.9000207@us.ibm.com>
References: <3DAB6385.9000207@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> 4) An ordered zone list is probably the more natural mapping.
>>> 
>>> See my comments above about per zone/memblk.  And you reemphasize my point, how do we order the zone lists in such a way that a user of the API can easily know/find out what zone #5 is?
>> Could you explain how that problem is different from finding out
>> what memblk #5 is ... I don't see the difference?
> Errm...  __memblk_to_node(5)

As opposed to creating __zone_to_node(5) ?
 
> I"m not saying that we couldn't add a similar interface for zones... something along the lines of:
> 	__memblk_and_zone_to_flat_zone_number(5, DMA)
> or some such.  It just isn't there now...

Surely this would dispose of the need for memblks? If not, then
I'd agree it's probably just adding more complication.

M.

