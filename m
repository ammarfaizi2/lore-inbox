Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSKIHwH>; Sat, 9 Nov 2002 02:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264668AbSKIHwH>; Sat, 9 Nov 2002 02:52:07 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:16568 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S264666AbSKIHwG>; Sat, 9 Nov 2002 02:52:06 -0500
To: Matthew Wilcox <willy@debian.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       mochel@osdl.org, parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
References: <200211090451.UAA26160@baldur.yggdrasil.com>
	<20021109052150.T12011@parcelfarce.linux.theplanet.co.uk>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 09 Nov 2002 08:58:01 +0100
Message-ID: <wrp4rari392.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20021109052150.T12011@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <willy@debian.org> writes:

Matthew> (i'm gagging to write an EISA subsystem ;-).

Humm, please don't... :-)

maz@midlife-crisis:~$ ls -R /sys/bus/eisa/ 
/sys/bus/eisa/:
devices  drivers

/sys/bus/eisa/devices:
00:00  00:01  00:02

/sys/bus/eisa/drivers:
3c509

/sys/bus/eisa/drivers/3c509:
00:02
maz@midlife-crisis:~$ 

I have it working on x86 and Alpha, will test parisc and mips over the
week-end.

        M.
-- 
Places change, faces change. Life is so very strange.
