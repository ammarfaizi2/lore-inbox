Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280667AbRKFXPi>; Tue, 6 Nov 2001 18:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKFXP2>; Tue, 6 Nov 2001 18:15:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7439 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280667AbRKFXPP>; Tue, 6 Nov 2001 18:15:15 -0500
Subject: Re: Linux kernel 2.4 and TCP terminations per second.
To: imran.badr@cavium.com
Date: Tue, 6 Nov 2001 23:22:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <017001c16701$3de5c0a0$3b10a8c0@IMRANPC> from "Imran Badr" at Nov 06, 2001 12:25:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161FY0-0002AE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anybody know , what is the maximum number of TCP (http)
> terminations/per second a server (single/dual/.. processor)  in todays
> market can do, without much CPU load. The server would be running linux
> kernel 2.4 and apache web server.

If you are running any kind of high performance connections/second load then
you dont run apache. That isnt what apache is good at

thttpd will do 2000/sec on a decent box. zeus (non free) more, and tux
(kernel http accelerator) holds some records
