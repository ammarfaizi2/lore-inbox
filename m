Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276429AbRJPQPC>; Tue, 16 Oct 2001 12:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRJPQOw>; Tue, 16 Oct 2001 12:14:52 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16905 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276429AbRJPQOg>;
	Tue, 16 Oct 2001 12:14:36 -0400
Date: Tue, 16 Oct 2001 14:14:41 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM
In-Reply-To: <E15tV4X-0000PN-00@Princess>
Message-ID: <Pine.LNX.4.33L.0110161406550.6440-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, Allan Sandfeld wrote:

> A simplistic solution is more predictable, and therefor easier to
> write programs for that run well.

Except for the gimp, I haven't seen any application which
actually takes the VM subsystem into account when doing
its things, so this balloon doesn't fly.

> This is the same principle that makes modern processors fast.
> We only need to enable any kind of program, not any behavior,
> becouse that behavior might in fact be harmfull or inefficient.

When comparing Linux 2.0 and Linux 2.2 you'll see that with
the simplistic solution in Linux 2.2 it is MUCH easier to
trigger bad behaviour than with Linux 2.0.

You'll also see that it is easier to make a robust VM fast
than to make a fast VM robust. The former is hard, the latter
is practically impossible.

I readily agree that the initial implementation of the VM
for Linux 2.4 had some bad things, but I'm not parting with
the idea that a VM should be designed to deal with strange
and heavy loads.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

