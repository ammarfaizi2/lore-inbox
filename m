Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287322AbRL3Dtv>; Sat, 29 Dec 2001 22:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287324AbRL3Dtm>; Sat, 29 Dec 2001 22:49:42 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5128 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287322AbRL3Dtd>;
	Sat, 29 Dec 2001 22:49:33 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.12-ac3 with preemptible-kernel patch 
In-Reply-To: Your message of "Sat, 29 Dec 2001 23:19:00 -0000."
             <Pine.LNX.4.21.0112292301340.879-200000@pppg_penguin.linux.bogus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Dec 2001 14:49:16 +1100
Message-ID: <23569.1009684156@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001 23:19:00 +0000 (GMT), 
Ken Moffat <ken@kenmoffat.uklinux.net> wrote:
>Output from ksymoops attached, although I'm a little worried
>about the ksymoops warnings from the tulip and various audio modules - 
>do I need to worry about these warnings ?

Bug in handling exported bss symbols in modules.  Fixed in ksymoops 2.4.2.

