Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSLAIpE>; Sun, 1 Dec 2002 03:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSLAIpD>; Sun, 1 Dec 2002 03:45:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:33782 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261544AbSLAIpD>;
	Sun, 1 Dec 2002 03:45:03 -0500
Message-ID: <3DE9CDC7.CA5B7E49@digeo.com>
Date: Sun, 01 Dec 2002 00:52:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: data corrupting bug in 2.4.20 ext3, data=journal
References: <3DE9C43D.61FF79C5@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2002 08:52:23.0385 (UTC) FILETIME=[F71ABC90:01C29916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> The fix is to only apply the optimisation to inodes which are operating
> under data=ordered.
> 

That "fix" didn't fix it.  Sorry about that.

Please avoid ext3/data=journal until it is sorted out.
