Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUJGQIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUJGQIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 12:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJGQIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 12:08:38 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:59045 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267421AbUJGQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:00:33 -0400
Date: Thu, 07 Oct 2004 10:59:10 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>, Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [Lhms-devel] Re: [PATCH]  no buddy bitmap patch : intro and
 includes [0/2]
Message-ID: <FAFA5259CC7643EB8D87AF9B@[10.1.1.4]>
In-Reply-To: <1250100000.1097160319@[10.10.2.4]>
References: <41653511.60905@jp.fujitsu.com>
 <1250100000.1097160319@[10.10.2.4]>
X-Mailer: Mulberry/3.1.4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, October 07, 2004 07:45:21 -0700 "Martin J. Bligh"
<mbligh@aracnet.com> wrote:

>> Followings are patches for removing bitmaps from buddy allocator,
>> against 2.6.9-rc3. I think this version is much clearer than ones I
>> posted a month ago.
> ...
>> If there is unclear point, please tell me.
> 
> What was the purpose behind this, again? Sorry, has been too long since
> I last looked.

The memory allocator bitmaps are the main remaining reason we need the
concept of linear memory.  If we can get rid of them, it's one step closer
to managing memory as a set of sections.

Dave McCracken

