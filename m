Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316241AbSEQOcY>; Fri, 17 May 2002 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316242AbSEQOcX>; Fri, 17 May 2002 10:32:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8972 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316241AbSEQOcV>; Fri, 17 May 2002 10:32:21 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 17 May 2002 15:52:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <E178hJU-0002GS-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 17, 2002 10:58:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178j5g-0006en-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Again, like we did 12 months ago you mean?

We didnt fix them 12 months ago

> We could do that, or, we could fix the actual problem, which is the
> HUGE FUCKING BEARTRAP WHICH CATCHES EVERY SINGLE NEW PROGRAMMER ON THE
> WAY THROUGH.

Capital letters versus content. I'd prefer content

All the cases I looked at where replications of existing bugs copied from
old drivers. That doesn't say copy_*_user is wrong, it says lots of examples
people keep using are wrong

