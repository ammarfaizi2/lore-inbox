Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424237AbWLBRT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424237AbWLBRT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424245AbWLBRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:19:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36101 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424237AbWLBRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:19:27 -0500
Date: Sat, 2 Dec 2006 18:19:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Nathanael Nerode <neroden@fastmail.fm>,
       Andres Salomon <dilinger@debian.org>
Subject: RFC: removing the dgrs net driver
Message-ID: <20061202171932.GP11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the information in the email forwarded below I'd remove the 
dgrs net driver (this wasn't the first driver shipped with the kernel 
without any hardware ever produced...).

Is this OK or is there any doubt whether this information is true?

cu
Adrian


----- Forwarded message from Nathanael Nerode <neroden@fastmail.fm> -----

Date:	Sun, 24 Sep 2006 13:00:12 -0400
From: Nathanael Nerode <neroden@fastmail.fm>
To: netdev@vger.kernel.org
Subject: Please remove useless dgrs driver

An official email from digi.com to Andres Salomon <dilinger@debian.org>
explained:

 Dear Andres:

 After further research, we found that this product was killed in place
 and never reached the market.  We would like to request that this not be
 included.

Copy at http://wiki.debian.org/KernelFirmwareLicensing (this was discovered
during research into firmware licensing).

The drgs driver is useless (no hardware to drive) and should be removed.
The files which should be deleted from the tree are:
        drivers/net/dgrs.c
        drivers/net/dgrs.h
        drivers/net/dgrs_es4h.h
        drivers/net/dgrs_plx9060.h
        drivers/net/dgrs_i82596.h
        drivers/net/dgrs_ether.h
        drivers/net/dgrs_asstruct.h
        drivers/net/dgrs_bcomm.h
        drivers/net/dgrs_firmware.c

It will probably also be necessary to delete some stuff from drivers/net/Kconfig
and drivers/net/Makefile, but I assume that this will be trivial for any
net maintainer.

Thanks in advance for doing this.

-- 
Nathanael Nerode  <neroden@fastmail.fm>

"(Instead, we front-load the flamewars and grudges in
the interest of efficiency.)" --Steve Lanagasek,
http://lists.debian.org/debian-devel/2005/09/msg01056.html
-
To unsubscribe from this list: send the line "unsubscribe netdev" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

----- End forwarded message -----

