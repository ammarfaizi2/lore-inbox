Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbQKDUnr>; Sat, 4 Nov 2000 15:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQKDUni>; Sat, 4 Nov 2000 15:43:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17192 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129093AbQKDUnF>; Sat, 4 Nov 2000 15:43:05 -0500
Subject: Re: [PATCH] Re: Negative scalability by removal of  lock_kernel()?(Was:Strange
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Sat, 4 Nov 2000 20:43:41 +0000 (GMT)
Cc: andrewm@uow.edu.au (Andrew Morton), kumon@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011041203300.22526-100000@twinlark.arctic.org> from "dean gaudet" at Nov 04, 2000 12:11:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sAAB-0004nz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sysv semaphores have a very unfortunate negative feature -- if the admin
> kill -9's the server (impatient admins do this all the time) then you end
> up leaving a semaphore lying around.  sysvsem don't have the usual unix

Umm they have SEM_UNDO. Its a case of deeper magic


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
