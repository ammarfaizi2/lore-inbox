Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280042AbRKVQ5x>; Thu, 22 Nov 2001 11:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280043AbRKVQ5n>; Thu, 22 Nov 2001 11:57:43 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:32016 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280042AbRKVQ51>; Thu, 22 Nov 2001 11:57:27 -0500
Date: Thu, 22 Nov 2001 14:57:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: James A Sutherland <jas88@cam.ac.uk>
Cc: war <war@starband.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap vs No Swap.
In-Reply-To: <E166wPI-0005yT-00@mauve.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.33L.0111221456020.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, James A Sutherland wrote:
> On Thursday 22 November 2001 4:00 pm, war wrote:
> > Incorrect, my point is I have enough ram where I am not going to run out
> > for the things I do.

> Obviously, there are cases where removing swap breaks the system
> entirely, but even in other cases, adding swap should *never* degrade
> performance. (In theory, anyway; in practice, it still needs
> tuning...)

Not quite true.  The VM cannot look into the future, so if
you have swap it could have just swapped out the application
on the desktop you're about to switch to ;)

If you have more than enough swap, you can be sure that the
program data will stay in ram and at most the executable code
needs to be read in again from disk.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

