Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbTAAQhz>; Wed, 1 Jan 2003 11:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTAAQhz>; Wed, 1 Jan 2003 11:37:55 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:45535 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267276AbTAAQhy>; Wed, 1 Jan 2003 11:37:54 -0500
Date: Wed, 1 Jan 2003 14:45:44 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Hell.Surfers@cwctv.net
cc: linux-kernel@vger.kernel.org, "" <rms@gnu.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <085e72754031fc2DTVMAIL12@smtp.cwctv.net>
Message-ID: <Pine.LNX.4.50L.0301011439540.2429-100000@imladris.surriel.com>
References: <085e72754031fc2DTVMAIL12@smtp.cwctv.net>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002 Hell.Surfers@cwctv.net wrote:

> Why does the community continue to make pacts with a company that steals
> from its rivals, makes pacts with M$, and refuses to clearly GPL and

Ohhhh, a conspiracy theory.  I like conspiracy theories.
Do tell, what exactly is the conspiracy here and who are
the parties involved ?

> open source its work on drivers, there is a clear difference between
> their use of GPL files, and what the GPL says they can do. You cannot
> expect embedded kernel developers to GPL, if you excuse Nvidia, its a
> vain hope to grab M$ users, but in the long run it destroys the
> community.

Copyright law is pretty explicit about the situations the GPL
applies to.  If something can be reasonably considered to be
a "derivative work" of a GPL work, the GPL applies and the
new work needs to be GPL.

However, if the new work is NOT a derivative of a GPL work,
the author of that new work gets to choose the license freely.

The border gets determined by inclusion of a copyrightable
piece of GPL code.  Really small fragments of code and simple
defines aren't copyrightable, just like you can't copyright a
single musical note, but only a song.  If nvidia's driver only
uses some simple declarations from include files and no large
(>7 lines? >10lines? what's large?) inline functions AND the
nvidia driver uses only the standard interfaces to hook into the
Linux kernel, then it's not a derivative work and nvidia gets
to choose the license.

Feel free to get upset or eat your boots at any time you want,
it's not going to change copyright law.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
