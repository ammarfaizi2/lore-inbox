Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVKCSuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVKCSuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVKCSuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:50:21 -0500
Received: from wirelesslogix.com ([209.18.121.242]:62732 "EHLO
	mailrelay.wirelesslogixgroup.com") by vger.kernel.org with ESMTP
	id S1030429AbVKCSuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:50:19 -0500
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [was Re: Linux 2.6.14 ] Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"
Date: Thu, 3 Nov 2005 19:35:55 +0100
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org> <200510291214.34718.ak@suse.de> <20051031214859.GA3721@localhost.localdomain>
In-Reply-To: <20051031214859.GA3721@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031935.56160.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 22:48, Ravikiran G Thirumalai wrote:

> I agree it is ugly.  But it atleast shows and does what the comment says.
> Is reverting a bug-fix to mask another bug (probably due to a broken bios
> or user not setting the IOMMU in the bios) any cleaner?  Yes it doesn't
> show though ;)

I don't believe the problem is the AMD boxes here.

Anyways, with the dma_ops patch we can probably separate it cleanly
and avoid the problem.

-Andi
