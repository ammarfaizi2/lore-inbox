Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSCIA5N>; Fri, 8 Mar 2002 19:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292150AbSCIA5E>; Fri, 8 Mar 2002 19:57:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292130AbSCIA4t>; Fri, 8 Mar 2002 19:56:49 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: george@mvista.com (george anzinger)
Date: Sat, 9 Mar 2002 01:11:55 +0000 (GMT)
Cc: frankeh@watson.ibm.com, torvalds@transmeta.com (Linus Torvalds),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org
In-Reply-To: <3C894D87.FF70DD12@mvista.com> from "george anzinger" at Mar 08, 2002 03:47:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jVOt-0008Eh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > cmpxchg-doubleword, still its not fool proof.
> 
> Uh, just the pid would do.  Maybe reserve a bit to indicate contention,
> but surly one word would be enough.

Make it a dword, the 16bit pid is beginning to look strained on big
boxes
