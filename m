Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbREVOhE>; Tue, 22 May 2001 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbREVOgx>; Tue, 22 May 2001 10:36:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16912 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261793AbREVOgn>; Tue, 22 May 2001 10:36:43 -0400
Subject: Re: [PATCH] include/linux/coda.h
To: bodnar42@bodnar42.dhs.org (Me)
Date: Tue, 22 May 2001 15:34:03 +0100 (BST)
Cc: jaharkes@cs.cmu.edu (Jan Harkes), linux-kernel@vger.kernel.org
In-Reply-To: <01052207215501.32103@bodnar42.dhs.org> from "Me" at May 22, 2001 07:21:55 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152DEZ-0001y7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I should've been more specific. I'm trying to compile the Linux kernel 
> (2.4.5pre3) on a FreeBSD machine, which actually works quite well with this 
> patch applied. This is the only place in the core that FreeBSD gets hung up 

Why is your cross compiler outputting different symbols to a linux native 
compiler ?

> on (init/main.c seems to include it unconditionally). Some drivers may still  
> make incorrect assumptions about __linux__ being defined, though.

If __linux__ is not defined by the cross compiler, then the cross compiler
is broken. A cross compiler has the same environment as the native compiler
for the target. The only stuff that should break (well should as in might) is 
tools native built

Or am I misunderstanding the report ?


