Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbQJ1BBQ>; Fri, 27 Oct 2000 21:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbQJ1BBG>; Fri, 27 Oct 2000 21:01:06 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:15887 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130107AbQJ1BAv>;
	Fri, 27 Oct 2000 21:00:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Pavel Machek <pavel@suse.cz>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant) 
In-Reply-To: Your message of "Fri, 27 Oct 2000 19:45:13 +0200."
             <20001027194513.A1060@bug.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 12:00:43 +1100
Message-ID: <4309.972694843@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000 19:45:13 +0200, 
Pavel Machek <pavel@suse.cz> wrote:
>Would it be possible to keep 2.7.2.3? You still need 2.7.2.3 to
>reliably compile 2.0.X (and maybe even 2.2.all-but-latest?).

You can have multiple versions of gcc installed, just select the one to
use when you compile the kernel.

CC=gcc-2723 make 2.0 kernel
CC=gcc-2723 make 2.2 kernel
CC=egcs make 2.4 kernel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
