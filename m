Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbQLBU4O>; Sat, 2 Dec 2000 15:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbQLBU4E>; Sat, 2 Dec 2000 15:56:04 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:59187 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130344AbQLBUzt>; Sat, 2 Dec 2000 15:55:49 -0500
Date: Sat, 2 Dec 2000 22:32:54 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Matthew Kirkwood <matthew@hairy.beasts.org>, folkert@vanheusden.com,
        "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <Pine.LNX.3.96.1001202115753.27887T-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0012022229580.11907-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For a blocking fd, read(2) has always blocked until some data is
> available.  There has never been a guarantee, for any driver, that
> a read(2) will return the full amount of bytes requested.

I know. Still leaves lot's of people that assume that reading /dev/random
will return data, or will block.

I've seen lots of programs that will assume that if we request x bytes
from /dev/random it will return x bytes.

> There is no need to document this...  man read(2)  ;-)
> 
> 	Jeff


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
