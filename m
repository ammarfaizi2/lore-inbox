Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSKUUPC>; Thu, 21 Nov 2002 15:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSKUUPC>; Thu, 21 Nov 2002 15:15:02 -0500
Received: from pa158.zgierz.sdi.tpnet.pl ([213.77.180.158]:47525 "HELO
	ekatalog.com.pl") by vger.kernel.org with SMTP id <S263968AbSKUUPB>;
	Thu, 21 Nov 2002 15:15:01 -0500
Date: Thu, 21 Nov 2002 21:22:09 +0100
From: Filip djMedrzec Zyzniewski <lkml@filip.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Strange relations between scsi emulation and networking code.
Message-ID: <20021121202209.GA28005@ekatalog.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

That is my first mail here :). I get strange problems recording a cd. It
almost completely locks my network traffic.
Sometimes it seems that only TCP is locked, and UDP is fine, sometimes
everything is fine, and somethimes nothing gets through my link.


Hw & sw:

recorder:	Teac CD-W58E
internet link:	through RS232 interface

software:
kernel:		2.4.18, 2.4.19.
pppd:		2.4.1b2
cdrtools:	1.11a35

I'm using a recorder with scsi-emulation. Additional small problem is that
sometimes (unmounted) cd wouldn't open, and I need to cdrecord -eject.

Kernel logs are clean.

my kernel .config is here: http://www.src.filip.eu.org/kernel/config

I find it hard to trace this problem, that's why I am writing here :).


regards,

Filip djMedrzec Zyzniewski
