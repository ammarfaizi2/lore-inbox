Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTBJIXu>; Mon, 10 Feb 2003 03:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTBJIXu>; Mon, 10 Feb 2003 03:23:50 -0500
Received: from mithra.wirex.com ([65.102.14.2]:39697 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S264730AbTBJIXt>;
	Mon, 10 Feb 2003 03:23:49 -0500
Message-ID: <3E4763C8.5090100@wirex.com>
Date: Mon, 10 Feb 2003 00:33:12 -0800
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: torvalds@transmeta.com, LA Walsh <law@tlinx.org>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
References: <001001c2d0b0$cf49b190$1403a8c0@sc.tlinx.org>	<3E471F21.4010803@wirex.com> <20030210082140.A16436@infradead.org>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigAF0F7372B709FAE63D089637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF0F7372B709FAE63D089637
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

'Christoph Hellwig' wrote:

>On Sun, Feb 09, 2003 at 07:40:17PM -0800, Crispin Cowan wrote:
>  
>
>>[move security logic out to a module] It has many nice properties, but is much more invasive to the 
>>kernel. I think it is a very interesting idea for 2.7, and should be 
>>floated past the maintainers who will be impacted to see if it has a 
>>hope in hell.
>>    
>>
>*nod* and until we get that gets implemented we should remove the current
>mess..
>
Am I parsing this correctly, that we actually agree on something? :-) 
I.e. that the idea of moving all the security logic to a module has merit.

Naturally, I disagree that we should remove the current LSM. The current 
version was designed to be what Linus asked for. Many LSM people like 
the idea of moving all the security logic out to a module, as it makes 
the interface much cleaner. But it is also waaay beyond the scope of 
what Linus asked for. It involves re-factoring so much code that we did 
not think it could be done correctly on the first try, never mind trying 
to get many code maintainers to accept much larger patches.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html
			    Just say ".Nyet"


--------------enigAF0F7372B709FAE63D089637
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+R2PP5ZkfjX2CNDARAVrpAJ9YzJRTunsYKJPxlTBXCMufGUZGEgCeP1v7
9yR9A3BnIc4sPW4WOKq0HnM=
=AP7q
-----END PGP SIGNATURE-----

--------------enigAF0F7372B709FAE63D089637--

