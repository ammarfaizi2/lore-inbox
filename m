Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVAYSh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVAYSh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVAYSh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:37:28 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:55789 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262055AbVAYShB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:37:01 -0500
Message-ID: <41F691D6.8040803@comcast.net>
Date: Tue, 25 Jan 2005 13:37:10 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Tue, 25 Jan 2005, John Richard Moser wrote:
> 
>>It's kind of like locking your front door, or your back door.  If one is
>>locked and the other other is still wide open, then you might as well
>>not even have doors.  If you lock both, then you (finally) create a
>>problem for an intruder.
>>
>>That is to say, patch A will apply and work without B; patch B will
>>apply and work without patch A; but there's no real gain from using
>>either without the other.
> 
> 
> Sure there is. There's the gain that if you lock the front door but not 
> the back door, somebody who goes door-to-door, opportunistically knocking 
> on them and testing them, _will_ be discouraged by locking the front door.
> 

In the real world yes.  On the computer, the front and back doors are
half-consumed by a short-path wormhole that places them right next to
eachother, so not really.  :)

> Never mind that he still could have gotten in. After all, if you locked 
> the back door too, he might still have a crow-bar.
> 

Crowbars don't work in computer security.  The most you can do is slow
the machine down by infinite network requests or CPU hogging (web server
requests take CPU, even to reject) if *everything* else is perfect; but
the goal is to keep them out, since we live in reality and not fairyland
where we can even stop DDoSes from eating network BW.

> It is a logically fallacy to think that "perfect" is good. It's not. 
> Anybody who strives for perfection will FAIL. 
> 

No, you aim close.  You won't hit it, but you'll get close.

> What's good is "incremental changes". Something that everybody and his dog 
> can look at for five seconds and say "oh, that's obviously fine", and then 
> can get more testing (because "everybody and his dog" saying "that's fine" 
> doesn't actually prove much of anything).
> 
> This has nothing to do with security, btw. It's universally true. You get 
> absolutely nowhere by trying to redesign the world. 
> 

yeah, I'm just very security minded.  Don't mind me much.

> 		Linus
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFB9pHWhDd4aOud5P8RAoDBAJwIrXSd5Z6uDUoFFBUWP4y/0m/TLgCYrcEa
Qu0RrJrCbo4A0OCj8im4JQ==
=6pZA
-----END PGP SIGNATURE-----
