Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286356AbSAAWms>; Tue, 1 Jan 2002 17:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286360AbSAAWmi>; Tue, 1 Jan 2002 17:42:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3091 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286356AbSAAWmZ>; Tue, 1 Jan 2002 17:42:25 -0500
Date: Tue, 1 Jan 2002 14:41:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: NFS "dev_t" issues..
In-Reply-To: <3C323A56.C22E2864@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201011441300.13397-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Jan 2002, Jeff Garzik wrote:
>
> And, assignments "kdev_t foo = 0" become "kdev_t foo = NODEV".

Indeed.

> At least I hope so ;-)  The below patch fixes up rd.c and loop.c.

Looks good, applied,

		Linus

