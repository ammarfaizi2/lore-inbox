Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbQKDKy1>; Sat, 4 Nov 2000 05:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKDKyL>; Sat, 4 Nov 2000 05:54:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36126 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132533AbQKDKx6>; Sat, 4 Nov 2000 05:53:58 -0500
Subject: Re: [PATCH] Re: Negative scalability by removal of
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 4 Nov 2000 10:54:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8u0a0j$eol$1@penguin.transmeta.com> from "Linus Torvalds" at Nov 03, 2000 10:23:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13s0y9-0004TB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even 2.2.x can be fixed to do the wake-one for accept(), if required. 

Do we really want to retrofit wake_one to 2.2. I know Im not terribly keen to
try and backport all the mechanism. I think for 2.2 using the semaphore is a 
good approach. Its a hack to fix an old OS kernel. For 2.4 its not needed
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
