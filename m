Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUALNIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUALNIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:08:06 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:52961 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S266172AbUALNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:08:01 -0500
Date: Mon, 12 Jan 2004 08:07:37 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
To: Ian Kent <raven@themaw.net>
Cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <40029C19.409@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enigEC06537060425A855A49AC28;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEC06537060425A855A49AC28
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:

>On Fri, 9 Jan 2004, Mike Waychison wrote:
>
>  
>
>>>Indeed, I
>>>haven't solved my requirement of a transparent autofs filesystem aka.
>>>Solaris automounter again. A difficult problem that will require
>>>considerable effort.
>>>
>>>
>>>
>>>      
>>>
>>What do you mean by this?  Something that doesn't show up in
>>/proc/mounts?  I don't see this as much of an issue..  On any decently
>>large machine, there are so many entries anyway that /etc/mtab and
>>/proc/mounts become humanly unparseable anyhow.
>>    
>>
>
>Transparency of an autofs filesystem (as I'm calling it) is the situation
>where, given a map
>
>/usr	/man1	server:/usr/man1
>	/man2	server:/usr/man2
>
>where the filesystem /usr contains, say a directory lib, that needs to be
>available while also seeing the automounted directories.
>
>  
>
I see.  This requires direct mount triggers to do properly.  Trying to 
do it with some sort of passthrough to the underlying filesystem is a 
nightmare waiting to happen..

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enigEC06537060425A855A49AC28
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAApwcdQs4kOxk3/MRAgxRAJ41kSxekMyt39Ke4HakQsUWUnYWTACfUOq7
GcLnjaIeN5Z4V15fYeVMDFQ=
=1Y6P
-----END PGP SIGNATURE-----

--------------enigEC06537060425A855A49AC28--

