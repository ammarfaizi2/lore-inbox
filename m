Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263395AbREXHbo>; Thu, 24 May 2001 03:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263397AbREXHbe>; Thu, 24 May 2001 03:31:34 -0400
Received: from ns.caldera.de ([212.34.180.1]:27579 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263395AbREXHbY>;
	Thu, 24 May 2001 03:31:24 -0400
Date: Thu, 24 May 2001 09:31:17 +0200
Message-Id: <200105240731.f4O7VH104345@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac15
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010523200128.A15260@lightning.swansea.linux.org.uk>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010523200128.A15260@lightning.swansea.linux.org.uk> you wrote:

> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

> 		 Intermediate diffs are available from
> 			http://www.bzimage.org


> 2.4.4-ac15
> o	Merge Linus 2.4.5pre5
> 	| Also fixes a dumb bug in my mmx fixups I=20
> 	| managed to forget to test and spot
> o	Dump the ACPI changes - new ones are pending	(me)
> 	and the old ones are better than this lot
> o	Revert serial incompatibility pending nice fix	(me)
> o	Move a few other oddments to match Linus
> o	Rip format conversion out of the pwc driver	(me)
> 	| It belongs in user space..

You appear to have reverted the DAC960 driver back to the previous version.
Was this intended?

Ciao, Marcus

diff -u -r1.10 -r1.11
--- Documentation/README.DAC960 2001/05/03 13:02:39     1.10
+++ Documentation/README.DAC960 2001/05/23 21:56:42     1.11
@@ -1,17 +1,17 @@
    Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers

-                       Version 2.2.10 for Linux 2.2.18
-                       Version 2.4.10 for Linux 2.4.1
+                       Version 2.2.9 for Linux 2.2.17
+                       Version 2.4.9 for Linux 2.4.0

                              PRODUCTION RELEASE

-                              1 February 2001
+                              7 September 2000

