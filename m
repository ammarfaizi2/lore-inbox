Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312638AbSDQKxh>; Wed, 17 Apr 2002 06:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313313AbSDQKxg>; Wed, 17 Apr 2002 06:53:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61454 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312638AbSDQKxf>; Wed, 17 Apr 2002 06:53:35 -0400
Subject: Re: offtpic: GPL driver vs. non GPL driver
To: wom@tateyama.hu (Gabor Kerenyi)
Date: Wed, 17 Apr 2002 12:11:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204171937.48441.wom@tateyama.hu> from "Gabor Kerenyi" at Apr 17, 2002 07:37:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xnL9-00022l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First question: Is it possible to write the driver in GPL and then develop a 
> binary only LIB? (I think yes because the LIB is in user space)

Thats a legal question about derivative works again. Its a lawyer question.
Don't ask lawyers how to program, don't ask programmers how the law works 8)

In business terms a binary only driver means that it won't be considered for
the mainstream kernel and you will need to rebuild it for every exact kernel
version your customers want. Irrespective of the GPL/lib question it may be
helpful to provide your customers source code to the kernel part of the
driver if only so you don't have to keep recompiling it. VMware follows very
much this model - their kernel bits are source code, vmware itself is most
definitely proprietary and per copy licensed.

Alan
