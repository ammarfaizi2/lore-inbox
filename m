Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbREQTYV>; Thu, 17 May 2001 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbREQTYL>; Thu, 17 May 2001 15:24:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27652 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261517AbREQTX4>; Thu, 17 May 2001 15:23:56 -0400
Subject: Re: Linux 2.4.4-ac10
To: reality@delusion.de (Udo A. Steinberg)
Date: Thu, 17 May 2001 20:21:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3B041980.BC22BA38@delusion.de> from "Udo A. Steinberg" at May 17, 2001 08:33:36 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150TKW-0005x3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o apm.o apm.c
> {standard input}: Assembler messages:
> {standard input}:180: Warning: indirect lcall without `*'
> {standard input}:274: Warning: indirect lcall without `*'
> 
> Does anyone know what's up with that? Kernel problem or binutils issue?

binutils is issuing a correct warning but if we fix the warning old old binutils
will then refuse to assemble it right.
