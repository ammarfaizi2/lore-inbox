Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbULEUQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbULEUQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbULEUQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:16:10 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:33799 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261378AbULEUQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:16:07 -0500
Date: Sun, 5 Dec 2004 21:14:08 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/moxa.c: remove an unused function
In-Reply-To: <20041205170247.GR2953@stusta.de>
Message-ID: <Pine.LNX.4.61L.0412052112080.11466@rudy.mif.pg.gda.pl>
References: <20041205170247.GR2953@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-746264020-1102277648=:11466"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-746264020-1102277648=:11466
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 5 Dec 2004, Adrian Bunk wrote:

> The patch below removes an unused global function.
>
>
> diffstat output:
> drivers/char/moxa.c |   18 ------------------
> 1 files changed, 18 deletions(-)
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.10-rc1-mm3-full/drivers/char/moxa.c.old	2004-11-07 00:28:05.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-full/drivers/char/moxa.c	2004-11-07 00:28:41.000000000 +0100
> @@ -1765,7 +1765,6 @@
>  *	2.  MoxaPortEnable(int port);					     *
>  *	3.  MoxaPortDisable(int port);					     *
>  *	4.  MoxaPortGetMaxBaud(int port);				     *
>- *	5.  MoxaPortGetCurBaud(int port);				     *
>  *	6.  MoxaPortSetBaud(int port, long baud);			     *
>  *	7.  MoxaPortSetMode(int port, int databit, int stopbit, int parity); *
>  *	8.  MoxaPortSetTermio(int port, unsigned char *termio); 	     *
[..]

Prabaly it will be good renumber this or make unnumbered (and all other 
comments with "Function <num>:" :)

[..]
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-746264020-1102277648=:11466--
