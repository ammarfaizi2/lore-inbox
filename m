Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131676AbQJ2NWb>; Sun, 29 Oct 2000 08:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131684AbQJ2NWW>; Sun, 29 Oct 2000 08:22:22 -0500
Received: from d14144.dtk.chello.nl ([213.46.14.144]:24707 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S131676AbQJ2NWJ>;
	Sun, 29 Oct 2000 08:22:09 -0500
Message-Id: <m13psPR-000OXnC@amadeus.home.nl>
Date: Sun, 29 Oct 2000 14:22:01 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: rasmus@jaquet.dk (Rasmus Andersen)
cc: linux-kernel@vger.kernel.org
Subject: Re: Compile error in drivers/ide/osb4.c in 240-t10p6
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20001029144822.B622@jaquet.dk>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre15 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001029144822.B622@jaquet.dk> you wrote:

> The variable, osb4_revision, is inside a #ifdef CONFIG_PROC_FS block but
> I was not able to discern if the line where it is referred should be
> #ifdef'ed also. The following patch moves the variable declaration out-
> side the #ifdef block, as a blind guess...

This patch, and a lot of others of a similar nature, are in my test10pre6
compile patch at 

http://www.fenrus.demon.nl/t10p6.diff

Greetings,
    Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
