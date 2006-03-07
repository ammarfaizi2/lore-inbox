Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWCGVyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWCGVyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWCGVyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:54:09 -0500
Received: from xenotime.net ([66.160.160.81]:22428 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964784AbWCGVyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:54:08 -0500
Date: Tue, 7 Mar 2006 13:55:50 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reg Clemens <reg@dwf.com>
Cc: rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard
Message-Id: <20060307135550.79fb90ff.rdunlap@xenotime.net>
In-Reply-To: <200603071932.k27JW0UH003735@deneb.dwf.com>
References: <200603070340.k273ev0A003594@deneb.dwf.com>
	<1141703317.25487.142.camel@mindpipe>
	<200603070823.k278NE9o006674@deneb.dwf.com>
	<20060307081806.0af1d2c4.rdunlap@xenotime.net>
	<200603071820.k27IKSsm003595@deneb.dwf.com>
	<20060307104646.9b2e193d.rdunlap@xenotime.net>
	<200603071932.k27JW0UH003735@deneb.dwf.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006 12:32:00 -0700 Reg Clemens wrote:

> 
> > 
> > Both boot logs contains the Cannot messages.
> 
> Hadn't noticed that, since it worked, I hadnt looked that carefully, sorry.
> 
> > The "bad" log also contains:
> > Mar  7 10:58:41 deneb kernel: PCI: Failed to allocate mem resource #6:20000@48000000 for 0000:01:00.0
> > 
> 
> Yep.
> 
> > Is device 0:01:00.0 your Nvidia video card?
> > Is there an updated NVRM driver for it (guessing from your OK boot log)
> > for 2.6.15 or later?
> 
> Yes, I am running with the NVIDIA
>     NVIDIA-Linux-x86-1.0-6629-pkg1.run
> driver, tho the 'nv' in the system works.
> 
> > 
> > I suppose an lspci might help.  I dunno.
> ---
> 
> Mar  7 10:58:41 deneb kernel: PCI: Cannot allocate resource region 1 of device 
> 0000:05:01.0
> Mar  7 10:58:41 deneb kernel: PCI: Cannot allocate resource region 2 of device 
> 0000:05:01.0
> Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x500-0x53f has been 
> reserved
> Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x400-0x47f could not 
> be reserved
> Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x680-0x6ff has been 
> reserved
> Mar  7 10:58:41 deneb kernel: PCI: Failed to allocate mem resource 
> #6:20000@48000000 for 0000:01:00.0
> 
> -- 
> Im not sure what the significance of that is, just noticed the difference.

Hi Reg,
I think you'll need to file a bug at bugzilla.kernel.org for this,
including the boot logs (good + bad), lspci -v, etc.

---
~Randy
