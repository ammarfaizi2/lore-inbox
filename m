Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281559AbRKMJd6>; Tue, 13 Nov 2001 04:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281560AbRKMJdt>; Tue, 13 Nov 2001 04:33:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59911 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281559AbRKMJdl>; Tue, 13 Nov 2001 04:33:41 -0500
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 13 Nov 2001 09:41:03 +0000 (GMT)
Cc: neilb@cse.unsw.edu.au (Neil Brown),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3BF0B776.4EE31B94@mandrakesoft.com> from "Jeff Garzik" at Nov 13, 2001 01:02:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163a3z-0000Yi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Neil Brown wrote:
> > I'm still lamenting the loss of the "-Werror" compile switch....
> 
> Me too but the kernel won't build basic stuff in fs/*.c code on 64-bit
> platforms with it enabled...

Or some 32bit setups, in part because gcc isnt always very bright about
warnings on non-use of variables. I'd rather have a small number of expected
warnings than a pile of ifdefs and = 0 assignments that later mask a real
bug
