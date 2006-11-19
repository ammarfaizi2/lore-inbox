Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756512AbWKSI4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbWKSI4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 03:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756514AbWKSI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 03:56:46 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:61639 "EHLO
	aa013msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1756512AbWKSI4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 03:56:45 -0500
Date: Sun, 19 Nov 2006 09:56:28 +0100
From: Mattia Dongili <malattia@linux.it>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2 (Oops in class_device_remove_attrs during nodemgr_remove_host)
Message-ID: <20061119085628.GA3484@inferi.kami.home>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	bcollins@debian.org
References: <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de> <20061117071650.GA4974@inferi.kami.home> <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de> <20061118094706.GA17879@kroah.com> <455EEE17.4020605@s5r6.in-berlin.de> <455F3DED.3070603@s5r6.in-berlin.de> <455F7EDD.6060007@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455F7EDD.6060007@s5r6.in-berlin.de>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 10:45:01PM +0100, Stefan Richter wrote:
[...]
> It seems like one of the patches in -mm overwrites a device's list of
> children with junk.
> 
> Mattia, *if* your machine is able to compile and reboot into new
> kernels  really quickly, it would be nice if you could biject between
> the -mm patches. I suppose the following ones are those to concentrate
> on first:
> 
> broken-out/gregkh-driver-config_sysfs_deprecated-bus.patch
> broken-out/gregkh-driver-config_sysfs_deprecated-class.patch
> broken-out/gregkh-driver-config_sysfs_deprecated-device.patch
> broken-out/gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
> broken-out/gregkh-driver-driver-link-sysfs-timing.patch
> broken-out/gregkh-driver-sysfs-crash-debugging.patch
> broken-out/gregkh-driver-udev-compatible-hack.patch
> 
> But hold on, I will do one other thing after I sent this message; I'll
> test -mm with CONFIG_SYSFS_DEPRECATED=y.

Ok, will go through these patches first and let you know

-- 
mattia
:wq!
