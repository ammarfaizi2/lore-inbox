Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUJDSmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUJDSmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUJDSmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:42:35 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:15903 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268304AbUJDSmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:42:33 -0400
Message-ID: <9e47339104100411421bf077c4@mail.gmail.com>
Date: Mon, 4 Oct 2004 14:42:21 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Tonnerre <tonnerre@thundrix.ch>, Greg Ungerer <gerg@snapgear.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merging DRM and fbdev
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sf.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041004174700.GB30858@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104100220553c57624a@mail.gmail.com>
	 <Pine.LNX.4.58.0410030824280.2325@skynet>
	 <9e47339104100309468e6a64f@mail.gmail.com>
	 <20041004174700.GB30858@thundrix.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004 19:47:00 +0200, Tonnerre <tonnerre@thundrix.ch> wrote:
> On Sun, Oct 03, 2004 at 12:46:51PM -0400, Jon Smirl wrote:
> > But there does appear to be one other user of inter_module_...
> > MTD driver for "M-Systems Disk-On-Chip Millennium Plus"
> > mtd/devices/doc2001plus.c
> > mtd/chips/cfi_cmdset_0001.c
> 
> nvidia and  ati use them  as well, it  seems. Not that I'd  care about
> them, though. They can roll their own fixes as they decided to.

Nvidia and ATI probably use it because they are derived from Linux
DRM/AGP code. When I remove it from the Linux drivers it may disappear
from theirs too.

I CC'd a few of the email addresses in the MTD driver's source. 

-- 
Jon Smirl
jonsmirl@gmail.com
