Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRDSQhn>; Thu, 19 Apr 2001 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRDSQhg>; Thu, 19 Apr 2001 12:37:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131386AbRDSQhL>; Thu, 19 Apr 2001 12:37:11 -0400
Subject: Re: light weight user level semaphores
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 19 Apr 2001 17:38:23 +0100 (BST)
Cc: alonz@nolaviz.org (Alon Ziv),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz),
        drepper@cygnus.com (Ulrich Drepper)
In-Reply-To: <Pine.LNX.4.31.0104190849170.3842-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 19, 2001 09:03:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qHRp-0007Yc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can libraries use fast semaphores behind the back of the user? They might
> well want to use the semaphores exactly for things like memory allocator
> locking etc. But libc certainly cant use fd's behind peoples backs.

libc is entitled to, and most definitely does exactly that. Take a look at
things like gethostent, getpwent etc etc.

Alan

