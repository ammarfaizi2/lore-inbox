Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbQL1QS7>; Thu, 28 Dec 2000 11:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130993AbQL1QSt>; Thu, 28 Dec 2000 11:18:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64785 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130420AbQL1QSe>; Thu, 28 Dec 2000 11:18:34 -0500
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
To: aeb@veritas.com (Andries Brouwer)
Date: Thu, 28 Dec 2000 15:49:30 +0000 (GMT)
Cc: cr@sap.com (Christoph Rohland), marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        gilbertd@treblig.org (Dave Gilbert)
In-Reply-To: <20001228143429.A1402@veritas.com> from "Andries Brouwer" at Dec 28, 2000 02:34:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BfJ6-0003qw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So should we go for SUSv2?
> 
> No.
> I regard shm* as obsolete. New programs will probably not use it.
> So, the less we change the better. Moreover, the SUSv2 text is broken.

There are fundmental things shm* can do that mmap cannot. Does posix shm
handle those (leaving segments alive but unattached being the obvious one)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
