Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAKKw1>; Thu, 11 Jan 2001 05:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAKKwR>; Thu, 11 Jan 2001 05:52:17 -0500
Received: from jalon.able.es ([212.97.163.2]:19169 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129324AbRAKKwF>;
	Thu, 11 Jan 2001 05:52:05 -0500
Date: Thu, 11 Jan 2001 11:51:56 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac6
Message-ID: <20010111115156.A25299@werewolf.able.es>
In-Reply-To: <E14GX1V-0001T5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14GX1V-0001T5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 11, 2001 at 02:59:26 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.11 Alan Cox wrote:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.0-ac6

The PentiumIII misnaming in arch/i386/Makefile is still there:

--- linux-2.4.0-ac6/arch/i386/Makefile.org      Thu Jan 11 11:48:09 2001
+++ linux-2.4.0-ac6/arch/i386/Makefile  Thu Jan 11 11:48:21 2001
@@ -50,7 +50,7 @@
 CFLAGS += -march=i686
 endif
 
-ifdef CONFIG_M686FXSR
+ifdef CONFIG_MPENTIUMIII
 CFLAGS += -march=i686
 endif


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac5 #1 SMP Wed Jan 10 23:36:11 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
