Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268016AbTBMK1k>; Thu, 13 Feb 2003 05:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268019AbTBMK1k>; Thu, 13 Feb 2003 05:27:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50193 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268016AbTBMK1c>; Thu, 13 Feb 2003 05:27:32 -0500
Date: Thu, 13 Feb 2003 11:37:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Kill "testing by UNISYS" message
Message-ID: <20030213103721.GE14151@atrey.karlin.mff.cuni.cz>
References: <20030210171336.GA10875@elf.ucw.cz> <1044969854.12906.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044969854.12906.18.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > -	printk(KERN_INFO "Linux NET4.0 for Linux 2.4\n");
> > -	printk(KERN_INFO "Based upon Swansea University Computer Society NET3.039\n");
> > -
> 
> No problem with that but please ensure the Swansea University Computer Society part is
> already in, or ends up in the top of file comments so the copyright info is preserved.

Updated patch follows... hope it is okay this way.

									Pavel

--- clean/net/socket.c	2003-02-11 17:41:48.000000000 +0100
+++ linux/net/socket.c	2003-02-12 22:27:45.000000000 +0100
@@ -55,6 +55,7 @@
  *	This module is effectively the top level interface to the BSD socket
  *	paradigm. 
  *
+ *	Based upon Swansea University Computer Society NET3.039
  */
 
 #include <linux/config.h>
@@ -1854,9 +1855,6 @@
 {
 	int i;
 
-	printk(KERN_INFO "Linux NET4.0 for Linux 2.4\n");
-	printk(KERN_INFO "Based upon Swansea University Computer Society NET3.039\n");
-
 	/*
 	 *	Initialize all address (protocol) families. 
 	 */


-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
