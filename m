Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSHKHnB>; Sun, 11 Aug 2002 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318285AbSHKHlm>; Sun, 11 Aug 2002 03:41:42 -0400
Received: from u212-239-153-197.dialup.planetinternet.be ([212.239.153.197]:5638
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S318281AbSHKHlN>; Sun, 11 Aug 2002 03:41:13 -0400
Message-Id: <200208110743.g7B7hhFL024650@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.5.31 unresolved symbol: unregister_ata_driver
Date: Sun, 11 Aug 2002 09:43:43 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling ide-cd.c as a module on 2.5.31 needs this:

MCE

*** drivers/ide/main.c.orig     Sun Aug 11 08:51:01 2002
--- drivers/ide/main.c  Sun Aug 11 09:35:01 2002
***************
*** 1124,1129 ****
--- 1124,1131 ----
        }
  }
  
+ EXPORT_SYMBOL(unregister_ata_driver);
+ 
  EXPORT_SYMBOL(ide_hwifs);
  EXPORT_SYMBOL(ide_lock);
  

