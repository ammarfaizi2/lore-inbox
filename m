Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281126AbRKVIvO>; Thu, 22 Nov 2001 03:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281433AbRKVIvF>; Thu, 22 Nov 2001 03:51:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:2579 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281126AbRKVIvB>;
	Thu, 22 Nov 2001 03:51:01 -0500
Date: Thu, 22 Nov 2001 06:50:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: war <war@starband.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net>
Message-ID: <Pine.LNX.4.33L.0111220649090.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, war wrote:

> I do not understand something.
> How can having swap speed ANYTHING up?
>
> RAM = 1000MB/s.
> DISK = 10MB/s
>
> Ram is generally 1000x faster than a hard disk.

This also means that the the caching of files from your
filesystem (say, /usr/bin/netscape or /lib/libc.so) is
1000x faster than reading them from disk.

> No swap = fastest possible solution.

Not true if having no swap means you do not have enough
memory to cache /lib/libc.so ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

