Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRJHQDQ>; Mon, 8 Oct 2001 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276975AbRJHQCH>; Mon, 8 Oct 2001 12:02:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23822 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272818AbRJHQCA>; Mon, 8 Oct 2001 12:02:00 -0400
Subject: Re: [PATCH] Provide system call to get task id
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Mon, 8 Oct 2001 17:07:56 +0100 (BST)
Cc: dmccr@us.ibm.com (Dave McCracken),
        linux-kernel@vger.kernel.org (Linux Kernel),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <200110081552.f98Fqgw22690@ns.caldera.de> from "Christoph Hellwig" at Oct 08, 2001 05:52:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qcwe-00010e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	.long SYMBOL_NAME(sys_fcntl64)
> > +	.long SYMBOL_NAME(sys_gettid)
> >  	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */
> 
> I think there was a reason why this syscall is marked reserved,
> could you add it as Nr 224?  (223 is reserved in 2.4.11-pre as well).

Yep - 223 is provisionally the security() syscall for the LSM project
