Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSLQXoH>; Tue, 17 Dec 2002 18:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSLQXoH>; Tue, 17 Dec 2002 18:44:07 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:34029 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S265196AbSLQXoH> convert rfc822-to-8bit; Tue, 17 Dec 2002 18:44:07 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre1] scx200.c in arch/i386/kernel
Date: Wed, 18 Dec 2002 00:51:07 +0100
User-Agent: KMail/1.4.3
Cc: wingel@nano-system.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212180051.07749.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just compiled 2.4.21-pre1 for a consistency check with all configure options 
set to 'y' and found a file arch/i386/kernel/scx200.c which does not compile 
because of missing support in the Makefile. It is introduced by the 
2.4.21-pre1 patch by Marcelo. 

Is there a reason why it's in the kernel directory of the i386 architecture? 
This is a very unusual place.

I moved it to drivers/char/scx200.c and it compiles like a charme, after 
correcting the Makefiles. Is there any chance of moving it to from the arch 
directory to a more appropriate place? Or did I misunderstand?

I don't know the scx200 Nat Sem chips, I don't have one and I don't even care, 
it's just because I'm doing some thorough build checks on my new -jp kernel 
patch set.

Best regards,

Jörg

