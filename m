Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130675AbQJ1QVI>; Sat, 28 Oct 2000 12:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130864AbQJ1QU6>; Sat, 28 Oct 2000 12:20:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130675AbQJ1QUz>; Sat, 28 Oct 2000 12:20:55 -0400
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was:
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 28 Oct 2000 17:20:44 +0100 (BST)
Cc: kumon@flab.fujitsu.co.jp, ak@suse.de (Andi Kleen),
        viro@math.psu.edu (Alexander Viro),
        jmerkey@timpanogas.org (Jeff V. Merkey),
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org,
        okir@monad.swb.de (Olaf Kirch)
In-Reply-To: <39FAF4C6.3BB04774@uow.edu.au> from "Andrew Morton" at Oct 29, 2000 02:46:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pYis-0005Q0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The big question is: why is Apache using file locking so
> much?  Is this normal behaviour for Apache?

Apache uses file locking to serialize accept on hosts where accept either has
bad thundering heard problems or was simply broken with multiple acceptors


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
