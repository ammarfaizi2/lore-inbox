Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130425AbQK3Qlq>; Thu, 30 Nov 2000 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130356AbQK3Qlg>; Thu, 30 Nov 2000 11:41:36 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:1775 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S129539AbQK3Qht>; Thu, 30 Nov 2000 11:37:49 -0500
Date: Thu, 30 Nov 2000 14:06:55 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Bob Tanner <tanner@real-time.com>
cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: PROBLEM: do_try_free_pages failed for python
In-Reply-To: <20001129183919.B7640@real-time.com>
Message-ID: <Pine.LNX.4.21.0011301405450.26098-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Bob Tanner wrote:

> [1.] One line summary of the problem: PROBLEM: do_try_free_pages
> failed for python
> 
> [2.] Full description of the problem/report: Running 2.2.18pre22
> on a dual Sparc20 with 128Mb of RAM.

The important thing to know here is if you had swap
free when this error was occuring or not. If you
still had lots of swap free, this may mean that VM
in 2.2 still has some bugs left ...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
