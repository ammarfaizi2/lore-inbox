Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUDWTzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUDWTzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUDWTzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:55:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11529 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261204AbUDWTzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:55:10 -0400
Date: Fri, 23 Apr 2004 20:55:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423205504.B2896@flint.arm.linux.org.uk>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org,
	Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <1082723147.1843.14.camel@merlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1082723147.1843.14.camel@merlin>; from marcel@holtmann.org on Fri, Apr 23, 2004 at 02:25:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 02:25:49PM +0200, Marcel Holtmann wrote:
> I haven't tested it yet, but the same problem should apply to the
> bt3c_cs driver for the 3Com Bluetooth card. Are there any patches
> available that integrates the PCMCIA subsystem into the driver model, so
> we don't have to hack around it if a firmware download is needed?

Not yet.  It's something we're working towards, but its going to be
some time yet.  There's a fair queue of long outstanding patches
which need to be processed first.

Plus, before we can consider driver model in PCMCIA, we need to get
the object lifetimes properly sorted.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
