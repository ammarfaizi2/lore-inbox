Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbUKAMLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUKAMLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUKAMLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:11:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:50084 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261762AbUKAMLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:11:06 -0500
Date: Mon, 1 Nov 2004 13:07:04 +0100
From: Olaf Hering <olh@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Disambiguation for panic_timeout's sysctl
Message-ID: <20041101120704.GB24626@suse.de>
References: <Pine.LNX.4.53.0410311721470.20529@yvahk01.tjqt.qr> <20041101120227.GA24626@suse.de> <20041101120411.GA26958@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041101120411.GA26958@infradead.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Nov 01, Christoph Hellwig wrote:

> On Mon, Nov 01, 2004 at 01:02:27PM +0100, Olaf Hering wrote:
> >  On Sun, Oct 31, Jan Engelhardt wrote:
> > 
> > > 
> > > 
> > > The /proc/sys/kernel/panic file looked to me like it was something like
> > > /proc/sysrq-trigger -- until I looked into the kernel sources which reveal that
> > > it sets the variable "panic_timeout" in kernel/sched.c.
> > 
> > This will probably break applications that expect the filename 'panic'.
> 
> And why should applications care for the panic timeout?  Especially only
> a few days after it's been added to the kernel?

/proc/sys/kernel/panic exists since at least 2.6.5.
Its used to override the silly default '0' on i386, but one should be
able to boot with panic=$bignum

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
