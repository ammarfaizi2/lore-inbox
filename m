Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbUAIVxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAIVxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:53:15 -0500
Received: from brmea-mail-2.Sun.COM ([192.18.98.43]:20406 "EHLO
	brmea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264568AbUAIVxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:53:00 -0500
Date: Fri, 09 Jan 2004 16:52:41 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFF16CE.6060407@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: trond.myklebust@fys.uio.no, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, raven@themaw.net, thockin@Sun.COM
Message-id: <3FFF22A9.8040206@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig594724CB2940F81366E01F7E;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>
 <3FFDB272.8030808@zytor.com>
 <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no>
 <3FFDC7F4.4070800@zytor.com> <3FFF1101.3090804@sun.com>
 <3FFF16CE.6060407@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig594724CB2940F81366E01F7E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>Mike Waychison wrote:
>  
>
>>H. Peter Anvin wrote:
>>
>>    
>>
>>>My point is that it's what you get for having an automounter.
>>>
>>>We can't solve Sun's designed-in braindamage, unfortunately.  This is
>>>partially why I'd like people to consider the scope of what automounting
>>>does; there are tons of policy issues not all of which are going to be
>>>appropriate in all contexts.  To some degree, if you have to have an
>>>automounter you have already lost.
>>> 
>>>      
>>>
>>However, we can solve Linux's designed-in braindamage.
>>
>>    
>>
>
>I was referring to the visibility of server-side mount points in NFS 2/3
>and the fact that most of the uses of the automounter is to work around
>this shortcoming.  This is a protocol limitation.
>
>  
>
It's just a different way of looking at it.   NFS exports filesystems,  
not namespaces.  It's the server implementation that decides it should 
try to map these exports to its local namespace.  Indeed, this is what 
exportfs and /etc/exports tries to do.  Nobody said this mapping made 
alot of sense.

>(Don't get me started on stuff like "plus lines" in map, which breaks
>the map paradigm completely.  That's brokenness on a whole other level,
>but which can be reasonably ignored.)
>
>  
>
Your on your own on that one.  I don't see it as an issue as the 
semantics are pretty well defined.

>It's trivial to crash most filesystem drivers (or get to a security leak
>level) by feeding them deliberately bad input.  Robustness against
>corruption in Linux has been with respect to likely data corruption much
>more than deliberate attacks.  It's a major effort; security-auditing
>every filesystem driver.
>  
>
Ok.  Thanks for clearing that up. 

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


--------------enig594724CB2940F81366E01F7E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//yKrdQs4kOxk3/MRAgvmAJ9VHNsgFOcEfg31vAQHMmDzVRpzmwCdHsnj
etNwJ3nBYsgjy92niDwv/Qg=
=y7IG
-----END PGP SIGNATURE-----

--------------enig594724CB2940F81366E01F7E--

