Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbREBLPz>; Wed, 2 May 2001 07:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132688AbREBLPp>; Wed, 2 May 2001 07:15:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14351 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132614AbREBLPa>; Wed, 2 May 2001 07:15:30 -0400
Subject: Re: Question on including 'math.h' from C runtime...
To: sjhill@cotw.com
Date: Wed, 2 May 2001 12:18:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3AEF7C43.9955C970@cotw.com> from "Steven J. Hill" at May 01, 2001 10:17:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uuep-0003Q4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> '/usr/include/math.h' in most cases. There are only two places
> in the kernel that also include this header file. They are:
> 
>    drivers/atm/iphase.c

That probably shouldnt be using it

>    drivers/net/hamradio/soundmodem/gentbl.c

This one is intentional. gentbl is a program linked in user space and used
to generate a .h file then built for the kernel
