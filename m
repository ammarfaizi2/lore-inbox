Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318879AbSIIWKS>; Mon, 9 Sep 2002 18:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318881AbSIIWKS>; Mon, 9 Sep 2002 18:10:18 -0400
Received: from u195-95-41-114.adsl.pi.be ([195.95.41.114]:55812 "EHLO
	jebril.pi.be") by vger.kernel.org with ESMTP id <S318879AbSIIWKR>;
	Mon, 9 Sep 2002 18:10:17 -0400
Message-Id: <200209092213.g89MDi27041311@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: 2.3.34
Date: Tue, 10 Sep 2002 00:13:43 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When trying to compile IDE as modules (I must be the only one :-), 
I still get:

ide.c:3673: redefinition of `init_module'
ide.c:3651: `init_module' previously defined here
{standard input}: Assembler messages:
{standard input}:9418: Error: symbol `init_module' is already defined
make[2]: *** [ide.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ide'
make[1]: *** [ide] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2

Not knowing which of the two is the correct one, but in desparate 
need of a working floppy driver, I tossed a coin to decide. Kernel 
is compiling as I write. But I'd really like to know what the 
correct fix is.

Regards,

MCE
-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a37 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

