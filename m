Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293402AbSBYNDe>; Mon, 25 Feb 2002 08:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293403AbSBYNDc>; Mon, 25 Feb 2002 08:03:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30222 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293402AbSBYNDE>; Mon, 25 Feb 2002 08:03:04 -0500
Subject: Re: your mail
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 25 Feb 2002 13:16:09 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), mingo@elte.hu,
        matthew@hairy.beasts.org (Matthew Kirkwood),
        bcrl@redhat.com (Benjamin LaHaise), david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <E16fA92-0007en-00@wagner.rustcorp.com.au> from "Rusty Russell" at Feb 25, 2002 12:41:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fKzB-0004qY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	fd = sem_initialize();
> > 	mmap(fd, ...)
> > 	..
> > 	munmap(..)
> > 
> > which gives you a handle for the semaphore.
> 
> No no no!  Implemented exactly that (and posted to l-k IIRC), and it's
> *horrible* to use.

All Linus forgot was to sem_initialize("filename"); With that the rest
comes out for free.
