Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313509AbSDGXXv>; Sun, 7 Apr 2002 19:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313510AbSDGXXu>; Sun, 7 Apr 2002 19:23:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39945 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313509AbSDGXXt>; Sun, 7 Apr 2002 19:23:49 -0400
Subject: Re: 2.4.18 AND Geode GX1/200Mhz problem
To: pierre.ficheux@openwide.fr (Pierre Ficheux)
Date: Mon, 8 Apr 2002 00:41:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CB0D419.F785C6D0@openwide.fr> from "Pierre Ficheux" at Apr 08, 2002 01:19:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uMHW-0006vK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I have a strange problem with a Geode/GX1 200Mhz based system. My
> kernel is compiled  with 586 as processor type but the system stops just
> after the 'Uncompressing Linux...Ok, booting the kernel' message. It's
> strange as GX1 is claimed to work fine with 2.4.18. The same system
> works fine with 2.2.18 kernel.

With 586 and no TSC set it should work fine yes. You might want to plug a 
serial port in and compile with serial console enabled, see if it gives any
clues
