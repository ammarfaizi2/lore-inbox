Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284272AbRLXA6m>; Sun, 23 Dec 2001 19:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbRLXA6c>; Sun, 23 Dec 2001 19:58:32 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:62728 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284272AbRLXA6V>;
	Sun, 23 Dec 2001 19:58:21 -0500
Date: Sun, 23 Dec 2001 22:58:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5] support for NCR voyager 
 343x/345x/4100/51xx architecture
In-Reply-To: <200112231913.fBNJDgt01933@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0112232256180.12081-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, James Bottomley wrote:

> The NCR voyager architecture is essentially a precursor ...

One thing which worries me is that the number of
these machines is very small, so the code could
temporarily go the way the SGI visws code went.

It would be nice if this code was split out in
such a way that it won't have any impact on the
maintainability of the mainstream code, so even
if the voyager folks go on holiday, normal Linux
development can continue and the resulting bitrot
will be limited to just the voyager code.

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

