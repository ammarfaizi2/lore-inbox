Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbRGCBQv>; Mon, 2 Jul 2001 21:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266187AbRGCBQl>; Mon, 2 Jul 2001 21:16:41 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:22935 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S266185AbRGCBQ1>;
	Mon, 2 Jul 2001 21:16:27 -0400
Date: Sun, 1 Jul 2001 01:54:05 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Rudolf Polzer <rpolzer@durchnull.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: drivers/char/vt.c allows virtually locking up nonnetworked
 machine
In-Reply-To: <20010630231040.A3501@www42.durchnull.de>
Message-ID: <Pine.LNX.4.33L2.0107010148170.28941-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001, Rudolf Polzer wrote:

> There is a problem concerning chvt. A normal user can run a
>
> bash$ while [ 1 ]; do chvt 11; done
>
> which cannot be killed using the console (only remotely, virtually never
> on a nonnetworked multiuser machine). So I changed the kernel source code
> so that only the superuser may change terminals.
Ok, lemme see if I got this right. What exactly do you mean by 'a normal
user' or a 'nonnetworked machine'. If the machine is non-networked, then
it must be sort of single user. Oh yea, and if someone logs on from your
console, smack them and don't patch the kernel.

Oh yeah, I can imagine a few situations in which this would be necessary.
But if someone you don't trust logs on from your (non-networked) console
and has time to play with it, you're screwed anyway.

Dan.


