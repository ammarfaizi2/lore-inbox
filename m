Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSEQTYo>; Fri, 17 May 2002 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSEQTYn>; Fri, 17 May 2002 15:24:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316662AbSEQTYn>; Fri, 17 May 2002 15:24:43 -0400
Subject: Re: ide cd/dvd with 2.4.19-pre8
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 17 May 2002 20:15:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1x1ycak586.fsf@gladiusit.e.kth.se> from "=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=" at May 17, 2002 08:18:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178nCf-00076R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just noticed that reading from both my cdrom and dvd is a lot slower
> with 2.4.19-pre8 than 2.4.18. Now hdparm reports ~800 kbytes/s compared=
>  to
> 1.7 MBytes/s for CD and >2 MBytes/s for DVD with 2.4.18. It is even imp=
> ossible
> to play DVDs. Any ideas?

Did you include support for your controller. Are you in fact now in PIO
mode because you didnt ?
