Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271946AbRIIMKH>; Sun, 9 Sep 2001 08:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271950AbRIIMJ5>; Sun, 9 Sep 2001 08:09:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16145 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271946AbRIIMJn>; Sun, 9 Sep 2001 08:09:43 -0400
Date: Sun, 9 Sep 2001 09:09:53 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <Pine.LNX.4.33.0109082115270.1161-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109090909001.21049-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2001, Linus Torvalds wrote:

> It's only filesystems that have modified buffers without marking them
> dirty (by virtue of having pointers to buffers and delaying the dirtying
> until later) that are broken by the "try to make sure all buffers are
> up-to-date by reading them in" approach.

Think of the inode and dentry caches.  I guess we need
some way to invalidate those.

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

