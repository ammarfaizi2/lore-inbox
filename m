Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129186AbQJ2XYh>; Sun, 29 Oct 2000 18:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129295AbQJ2XY1>; Sun, 29 Oct 2000 18:24:27 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:17405 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S129186AbQJ2XXx>; Sun, 29 Oct 2000 18:23:53 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant) 
In-Reply-To: Your message of "Sat, 28 Oct 2000 12:00:43 +1100."
             <4309.972694843@ocs3.ocs-net> 
Date: Mon, 30 Oct 2000 10:23:46 +1100
Message-Id: <20001029232347.D4EB081F9@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <4309.972694843@ocs3.ocs-net> you write:
> On Fri, 27 Oct 2000 19:45:13 +0200, 
> Pavel Machek <pavel@suse.cz> wrote:
> >Would it be possible to keep 2.7.2.3? You still need 2.7.2.3 to
> >reliably compile 2.0.X (and maybe even 2.2.all-but-latest?).
> 
> You can have multiple versions of gcc installed, just select the one to
> use when you compile the kernel.
> 
> CC=gcc-2723 make 2.0 kernel
> CC=gcc-2723 make 2.2 kernel
> CC=egcs make 2.4 kernel

No, environment doesn't override make variables by default.  This
works on any shell:

	make CC=egcs <targets>

Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
