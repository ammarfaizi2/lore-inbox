Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUDWSwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUDWSwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 14:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUDWSwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 14:52:01 -0400
Received: from linux-bt.org ([217.160.111.169]:34179 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262488AbUDWSv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 14:51:59 -0400
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Simon Kelley <simon@thekelleys.org.uk>
In-Reply-To: <20040423171614.GA13835@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net>
	 <200404230802.42293.dtor_core@ameritech.net>
	 <1082730412.23959.118.camel@pegasus>
	 <200404231156.03106.dtor_core@ameritech.net>
	 <20040423171614.GA13835@kroah.com>
Content-Type: text/plain
Message-Id: <1082746253.23959.126.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 20:50:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Much nicer (well, in a wierd way at least.)  It seems that the pcmcia
> system is intregrated into the driver model.  Why not push it down into
> the individual pcmcia drivers so you don't have to do this GetSysDevice
> kind of hack still?

let's split the patch into a PCMCIA subsystem part and atmel_cs part and
even if it looks like a hack we need it, because otherwise the atmel_cs
and bt3c_cs drivers are broken now.

Regards

Marcel


