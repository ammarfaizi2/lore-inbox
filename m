Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316508AbSEOWaf>; Wed, 15 May 2002 18:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316509AbSEOWaf>; Wed, 15 May 2002 18:30:35 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49168 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316508AbSEOWad>; Wed, 15 May 2002 18:30:33 -0400
Date: Wed, 15 May 2002 19:30:18 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
In-Reply-To: <20020515212733.GA1025@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0205151929430.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Andrea Arcangeli wrote:

> Only in 2.4.19pre8aa3: 00_ext3-register-filesystem-lifo-1
>
> 	Make sure to always try mounting with ext3 before ext2 (otherwise
> 	it's impossible to mount the real rootfs with ext3 if ext3 is a module
> 	loaded by an initrd and ext2 is linked into the kernel).

Funny, I've been doing this for months.

Maybe you should look into pivot_mount(2) and pivot_mount(8)
some day ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

