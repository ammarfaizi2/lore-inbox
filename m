Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318959AbSHTOWd>; Tue, 20 Aug 2002 10:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318987AbSHTOWd>; Tue, 20 Aug 2002 10:22:33 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:58260 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S318959AbSHTOWc>;
	Tue, 20 Aug 2002 10:22:32 -0400
Date: Tue, 20 Aug 2002 16:26:34 +0200
To: hermes@gibson.dropbear.id.au
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au
Subject: [PATCH] Remove extraneous ptrace.h include in hermes.c
Message-ID: <20020820142634.GB577@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extraneous ptrace.h include in hermes.c

-- 

//anders/g

diff -Nru a/drivers/net/wireless/hermes.c b/drivers/net/wireless/hermes.c
--- a/drivers/net/wireless/hermes.c	Tue Aug 20 16:19:49 2002
+++ b/drivers/net/wireless/hermes.c	Tue Aug 20 16:19:49 2002
@@ -45,7 +45,6 @@
 #include <linux/threads.h>
 #include <linux/smp.h>
 #include <asm/io.h>
-#include <linux/ptrace.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
