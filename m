Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268285AbRHFMnF>; Mon, 6 Aug 2001 08:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268287AbRHFMmz>; Mon, 6 Aug 2001 08:42:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8721 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268285AbRHFMmm>; Mon, 6 Aug 2001 08:42:42 -0400
Subject: Re: kernel headers & userland
To: abraham@2d3d.co.za (Abraham vd Merwe)
Date: Mon, 6 Aug 2001 13:41:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Development),
        leitner@fefe.de (Felix von Leitner)
In-Reply-To: <20010806095638.A5638@crystal.2d3d.co.za> from "Abraham vd Merwe" at Aug 06, 2001 09:56:38 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TjhH-0000u9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apparently Linus told Felix von Leitner (the author of dietlibc - a small,
> no nonsense glibc replacement C library) a while ago _not_ to include any
> linux kernel headers in userland (i.e. the C library headers in this case).

Did Felix make clear that it was a library he was talking about ?

> In short, there is simply too many things that will break if you don't
> include linux kernel headers in the C library headers (just look at glibc
> for instance).

Absolutely. But the main issue is applications. I certainly have no problem
with glibc using kernel header copies. Its when they leak into generic apps
directly it gets ugly

(And note glibc uses copies..)
