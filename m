Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279805AbRKFRjY>; Tue, 6 Nov 2001 12:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279852AbRKFRjP>; Tue, 6 Nov 2001 12:39:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57354 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279805AbRKFRi6>; Tue, 6 Nov 2001 12:38:58 -0500
Subject: Re: Using %cr2 to reference "current"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 6 Nov 2001 17:46:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9s956o$24b$1@penguin.transmeta.com> from "Linus Torvalds" at Nov 06, 2001 05:04:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161AIX-0001BL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We pretty much know the _theory_ is not correct, just by virtue of
> depending on non-architected behaviour.  The only thing -ac can do is
> test whether it works in practice.  Which is a totally different thing. 

Yep

> Especially on x86 chips.

Well so far I've found one laptop that eats %cr2 on APM calls, and we have
some mystery cases. Peter's suggestion of using %fs or %gs looks more
promising at the moment

