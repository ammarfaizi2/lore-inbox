Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVBGSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVBGSbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVBGSbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:31:44 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:38786 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261230AbVBGSbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:31:13 -0500
Message-ID: <4207B3E5.6040101@comcast.net>
Date: Mon, 07 Feb 2005 13:31:01 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Peter Busser <busser@m-privacy.de>, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
References: <4201DBE7.30569.2F5D446@localhost> <200502031455.22100.busser@m-privacy.de> <Pine.LNX.4.61.0502031537410.6118@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0502031537410.6118@scrub.home>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Roman Zippel wrote:
> Hi,
> 
> On Thu, 3 Feb 2005, Peter Busser wrote:
> 
> 
>>- What happens when you run existing commercial applications which have not 
>>been compiled using GCC.
> 
> 
>>From http://pax.grsecurity.net/docs/pax.txt:
> 
>    The goal of the PaX project is to research various defense mechanisms
>    against the exploitation of software bugs that give an attacker arbitrary
>    read/write access to the attacked task's address space. 
> 
> Could you please explain how PaX makes such applications secure?
> 

I wrote an easy-to-chew article[1] about PaX on Wikipedia, although
looking back at it I think there may be some erratta in the ASLR
concept; I think the mmap() base is randomized, but I'm not sure now if
the actual base of each mmap() call is individually randomized as shown
in my diagrams.  I'm also no longer sure where I got the notion that the
heap/.bss/data segments are the same entity, and I'll have to check on that.

Nevertheless, it's basically accurate, in the same way that saying you
have a gameboy advance SP when you just have a gameboy advance is
basically accurate.

[1] http://en.wikipedia.org/wiki/PaX

> bye, Roman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCB7PlhDd4aOud5P8RAr+pAKCCcbqLuG7OQzZlJrd5UdsA3NooUgCePXnp
D+xS98fWm9MVEBZpB+pIrTY=
=r+20
-----END PGP SIGNATURE-----
