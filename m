Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLAU7X>; Fri, 1 Dec 2000 15:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbQLAU7E>; Fri, 1 Dec 2000 15:59:04 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:11268 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129345AbQLAU6n>; Fri, 1 Dec 2000 15:58:43 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14888.2425.880686.391244@wire.cadcamlab.org>
Date: Fri, 1 Dec 2000 14:26:33 -0600 (CST)
To: Marc Mutz <Marc@Mutz.com>
Cc: Android <android@turbosport.com>, linux-kernel@vger.kernel.org
Subject: Re: [uPATCH] Re: Questions about Kernel 2.4.0.*
In-Reply-To: <001c01c05a86$45bb6380$19211518@vnnys1.ca.home.com>
	<20001130060732.A14250@wire.cadcamlab.org>
	<3A27CB48.38A1907C@Mutz.com>
	<14887.60824.271322.811343@wire.cadcamlab.org>
	<3A27F00B.4A431099@Mutz.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Marc Mutz]
> > +TOPDIR := $(shell pwd -P)

> That is specific to the bash builtin 'pwd'. GNU sh-util's pwd does
> not know that option (at least not my version, which is: "pwd (GNU
> sh-utils) 1.16")

It passed my 5-second shell feature portability test (ash).  Checking
again, I see that the ash 'pwd' just ignores its arguments, but doesn't
need '-P' because it doesn't maintain an internal pwd....  Oh well.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
