Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266242AbRF3STt>; Sat, 30 Jun 2001 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266238AbRF3STj>; Sat, 30 Jun 2001 14:19:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19984 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266241AbRF3STY>; Sat, 30 Jun 2001 14:19:24 -0400
Subject: Re: 2.4.6-pre8 build error of aic7xxxt
To: bbm@studioorange.de (Bernfried Molte)
Date: Sat, 30 Jun 2001 19:19:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010630201236.69fcdddd.bbm@studioorange.de> from "Bernfried Molte" at Jun 30, 2001 08:12:36 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15GPL3-0002FV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
> > /usr/i486-linux/bin/ld: cannot open -ldb: No such file or directory
> > collect2: ld returned 1 exit status
> > make[5]: *** [aicasm] Error 1
> > [...]
> > ----------------------------------------------------------------------
> 
> may be a 'make mrproper' solves your problem,

Unlikely since the problem is the fact that the scsi firmware assembler wants
a library that isnt installed.  


