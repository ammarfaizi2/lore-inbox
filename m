Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316054AbSEJQJN>; Fri, 10 May 2002 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316056AbSEJQIL>; Fri, 10 May 2002 12:08:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316058AbSEJQHk>; Fri, 10 May 2002 12:07:40 -0400
Subject: Re: mmap, SIGBUS, and handling it
To: dizzy@roedu.net (Mihai RUSU)
Date: Fri, 10 May 2002 17:27:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205101832080.9661-100000@ahriman.bucharest.roedu.net> from "Mihai RUSU" at May 10, 2002 06:37:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E176DEd-0006CC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> truncates the file which was mmap-ed , our program will receive a SIGBUS
> in write().
> 
> If I understand right this is more POSIX compliant.
> 
> Is there a clean/good way of handling this ?

sigsetjmp/siglongjmp

