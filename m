Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUGQVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUGQVap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 17:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUGQVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 17:30:44 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:17575 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261987AbUGQVam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 17:30:42 -0400
Message-ID: <40F99A7A.7060405@sci.fi>
Date: Sun, 18 Jul 2004 00:30:34 +0300
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVuIC8gVHJvbmlj?= <tronic2@sci.fi>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040314)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OT: tabs and spaces
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF1CD5B4C52121183B4E6B5E9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1CD5B4C52121183B4E6B5E9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

When you write prettyprinters, programmers' editors or anything that 
does some kind of code indentation, please take care of the following rules:

1. NEVER convert N spaces into one tab; they are not equal with any N
2. count spaces and tabs separately (one tab for each { }, etc)
3. if aligning with anything (text, not indent), use spaces only
4. print tab chars at the very beginning of the line, never after any 
other characters

GNU indent and all other prettyprinters I know of violate the first 
three rules. I chose to write LKML because so many people writing 
indenting software, or just writing code, will be reading this now...

If the indentation is done this way, it never breaks with any tab width. 
The only (minor) issue concerns cutting long lines, because you cannot 
know the line length if you don't know tab length.

Before the flamewar begins: I am not saying that tab indentation or 
space indentation is better, just saying that the regular tab 
indentation is not optimal. So far I haven't seen anyone thinking that 
the regular way is better than this one, so there doesn't seem to be any 
debate about that.

If you agree with the above, please spread the message :)

As this is clearly off-topic, it may be better to answer to me only, not 
to the list.

- Tronic -

--------------enigF1CD5B4C52121183B4E6B5E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA+ZqAOBbAI1NE8/ERArh+AKCJYR+1g6TGB1UhyFxU/xM7rwAsJwCfcKZT
Po+mndvfkL153V1In+IXcbQ=
=XG6W
-----END PGP SIGNATURE-----

--------------enigF1CD5B4C52121183B4E6B5E9--
