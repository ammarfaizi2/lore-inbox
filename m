Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVC0IeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVC0IeD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVC0IeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:34:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2762 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261457AbVC0IeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:34:00 -0500
Date: Sun, 27 Mar 2005 10:33:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Dyck <david.dyck@fluke.com>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: upgrading modutils may have fixed: unresolved symbols still in
 2.4.30-rc2 (usbserial needs symbol tty_ldisc_ref and tty_ldisc_deref which
 are EXPORT_SYMBOL_GPL)
In-Reply-To: <Pine.LNX.4.62.0503261512380.228@dd.tc.fluke.com>
Message-ID: <Pine.LNX.4.61.0503271032150.22393@yvahk01.tjqt.qr>
References: <Pine.LNX.4.62.0503261052050.1495@dd.tc.fluke.com>
 <20050326191306.GE3237@stusta.de> <Pine.LNX.4.62.0503261158220.206@dd.tc.fluke.com>
 <Pine.LNX.4.62.0503261512380.228@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried again with 2.4.30-rc3, but this time I changed my .config
> file to disable 2 other modules that I didn't need, and wasn't loading.
>
> < CONFIG_USB_UHCI_ALT=m
> < CONFIG_USB_STV680=m
>
> and build rc3.  It seems to work, so either my earlier
>[...]

As for the subject, it constantly happens to me that I get unresolved symbols 
if I try to build a kernel with _*all*_ the bell's and whistles. There's 
always something that is not updated.



Jan Engelhardt
-- 
No TOFU for me, please.
