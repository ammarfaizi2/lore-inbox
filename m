Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUDWUO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUDWUO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUDWUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:14:58 -0400
Received: from linux-bt.org ([217.160.111.169]:10372 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261258AbUDWUOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:14:38 -0400
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
In-Reply-To: <20040423205504.B2896@flint.arm.linux.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net>
	 <1082723147.1843.14.camel@merlin>
	 <20040423205504.B2896@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1082751264.4294.1.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 22:14:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> > I haven't tested it yet, but the same problem should apply to the
> > bt3c_cs driver for the 3Com Bluetooth card. Are there any patches
> > available that integrates the PCMCIA subsystem into the driver model, so
> > we don't have to hack around it if a firmware download is needed?
> 
> Not yet.  It's something we're working towards, but its going to be
> some time yet.  There's a fair queue of long outstanding patches
> which need to be processed first.
> 
> Plus, before we can consider driver model in PCMCIA, we need to get
> the object lifetimes properly sorted.

should we apply the pcmcia_get_sys_device() patch from Dmitry for now to
fix the current drivers that need a device for loading the firmware?

Regards

Marcel


