Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSIJTWn>; Tue, 10 Sep 2002 15:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSIJTWn>; Tue, 10 Sep 2002 15:22:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:11526 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318038AbSIJTWm>; Tue, 10 Sep 2002 15:22:42 -0400
Date: Tue, 10 Sep 2002 16:27:22 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0209101626350.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Linus Torvalds wrote:

> So I claim a BUG() that locks up the machine is useless. If the user
> can't just run ksymoops and email out the BUG message, that BUG() is
> _not_ fine on SMP.

Agreed.  Along those same lines, it would be nice if the kernel
could spit out symbolic names so the user can't screw up the
backtrace and we've got a better chance of extracting a useful
bug report from our users ;)

regards,

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

