Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRCGAqd>; Tue, 6 Mar 2001 19:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129795AbRCGAqX>; Tue, 6 Mar 2001 19:46:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129774AbRCGAqO>; Tue, 6 Mar 2001 19:46:14 -0500
Subject: Re: Error compiling aic7xxx driver on 2.4.2-ac13
To: kernel@theoesters.com (Phil Oester)
Date: Wed, 7 Mar 2001 00:49:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000f01c0a697$3b1924f0$0200a8c0@theoesters.com> from "Phil Oester" at Mar 06, 2001 03:43:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aS8Y-0001pn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make[5]: Entering directory
> `/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'
> lex  -t aicasm_scan.l > aicasm_scan.c
> gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm
> aicasm_symbol.c:39: db/db_185.h: No such file or directory

You need db3/db3-devel installed
