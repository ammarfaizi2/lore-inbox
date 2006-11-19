Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756747AbWKSQWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbWKSQWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 11:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756749AbWKSQWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 11:22:48 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:64234 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1756747AbWKSQWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 11:22:48 -0500
Date: Sun, 19 Nov 2006 17:22:20 +0100
From: Mattia Dongili <malattia@linux.it>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: ohci1394 oops bisected [was Re: 2.6.19-rc5-mm2 (Oops in class_device_remove_attrs during nodemgr_remove_host)]
Message-ID: <20061119162220.GA2536@inferi.kami.home>
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
> broken-out/gregkh-driver-config_sysfs_deprecated-bus.patch
> broken-out/gregkh-driver-config_sysfs_deprecated-class.patch
> broken-out/gregkh-driver-config_sysfs_deprecated-device.patch
> broken-out/gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
> broken-out/gregkh-driver-driver-link-sysfs-timing.patch
> broken-out/gregkh-driver-sysfs-crash-debugging.patch
> broken-out/gregkh-driver-udev-compatible-hack.patch

Very close :) But no, the winner is...
gregkh-driver-network-device.patch

-- 
mattia
:wq!
