Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293423AbSBYQ1V>; Mon, 25 Feb 2002 11:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293424AbSBYQ1M>; Mon, 25 Feb 2002 11:27:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54799 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293423AbSBYQ1C>; Mon, 25 Feb 2002 11:27:02 -0500
Subject: Re: [PATCH] Lightweight userspace semaphores...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 25 Feb 2002 16:39:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
        mingo@elte.hu, matthew@hairy.beasts.org (Matthew Kirkwood),
        bcrl@redhat.com (Benjamin LaHaise), david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202250808150.3268-100000@home.transmeta.com> from "Linus Torvalds" at Feb 25, 2002 08:11:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fOAO-0005Ml-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	fd = open("/dev/shm/sem....");
> 
> Hmm.. Yes. Except I would allow a NULL backing store name for the
> normal(?) case of just wanting private anonymous memory.

unlink()

> At the same time, I have to admit that I like the notion that Rusty had of
> libraries being able to just put their semaphores anywhere (on the stack
> etc), as it does work for many architectures. Ugh.

_alloca
mmap

Still fits on the stack 8)

