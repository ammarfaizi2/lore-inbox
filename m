Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130364AbQKUMzG>; Tue, 21 Nov 2000 07:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129882AbQKUMy4>; Tue, 21 Nov 2000 07:54:56 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:52488 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130364AbQKUMyk>; Tue, 21 Nov 2000 07:54:40 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14874.27009.292507.909047@wire.cadcamlab.org>
Date: Tue, 21 Nov 2000 06:24:33 -0600 (CST)
To: Jakub Jelinek <jakub@redhat.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
In-Reply-To: <14874.25691.629724.306563@wire.cadcamlab.org>
	<20001121071327.R1514@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jakub Jelinek <jakub@redhat.com>]
> gcc was never dropping such strings, I've commited a patch to fix
> this a week ago into CVS.

Cool!  What about block-scoped 'static' variables?  Do those get
garbage-collected now as well?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
