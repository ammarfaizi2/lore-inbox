Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbQL3RMm>; Sat, 30 Dec 2000 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130989AbQL3RMc>; Sat, 30 Dec 2000 12:12:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65289 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130290AbQL3RMQ>; Sat, 30 Dec 2000 12:12:16 -0500
Subject: Re: test13-pre6 compile error..network.o
To: fdavis112@juno.com (Frank Davis)
Date: Sat, 30 Dec 2000 16:43:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20001230.030356.-209335.1.fdavis112@juno.com> from "Frank Davis" at Dec 30, 2000 03:03:51 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CP6v-0006mJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> net/network.o(.text+0x5ce78): undefined reference to `prepare_trdev'
> net/network.o(.text+0x5ce88): undefined reference to `prepare_etherdev'
> net/network.o(.text+0x5cee3): undefined reference to `publish_netdev'

My fault. I fed Linus a few things too many trying to get the networking
stuff tidied up. Stuff leaked in from the networking core fixes that arent
yet in Linus tree

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
