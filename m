Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280737AbRKJW2X>; Sat, 10 Nov 2001 17:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280736AbRKJW2D>; Sat, 10 Nov 2001 17:28:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10002 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280735AbRKJW15>; Sat, 10 Nov 2001 17:27:57 -0500
Subject: Re: test SYN cookies (was Re: SYN cookies security bugfix?)
To: ecashin@terry.uga.edu (Ed L Cashin)
Date: Sat, 10 Nov 2001 22:34:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <m34ro2ffk0.fsf@terry.uga.edu> from "Ed L Cashin" at Nov 10, 2001 05:04:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162giG-0007cI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there anyone who has any evidence that SYN cookies do anything in
> kernel 2.2.x?  If so, how did you get that evidence, because I would
> like to reproduce it.

They work fine for me in 2.2.19/2.2.20. Make sure you compile them in and 
turn them on. Also remember syn cookies ensure connection completions for
real connections, they dont deal with servers that simply cant keep up with
real work
