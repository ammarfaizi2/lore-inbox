Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSFIR6V>; Sun, 9 Jun 2002 13:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSFIR6U>; Sun, 9 Jun 2002 13:58:20 -0400
Received: from [195.39.17.254] ([195.39.17.254]:418 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314241AbSFIR6T>;
	Sun, 9 Jun 2002 13:58:19 -0400
Date: Sun, 2 Jun 2002 00:10:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Re: [PATCH] Futex Asynchronous Interface
Message-ID: <20020602001018.A35@toy.ucw.cz>
In-Reply-To: <E17FrfH-0006Gt-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Name: Waker can unpin page, rather than waiting process
> Author: Rusty Russell
> Status: Tested in 2.5.20
> Depends: Futex/copy-from-user.patch.gz Futex/unpin-page-fix.patch.gz
> Depends: Futex/waitq.patch.gz
> 
> D: This changes the implementation so that the waker actually unpins
> D: the page.  This is preparation for the async interface, where the
> D: process which registered interest is not in the kernel.

What is it? Nice header, did you generate it by hand?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

