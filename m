Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUKIBsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUKIBsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUKIBsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:48:16 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:10457 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261343AbUKIBlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:41:07 -0500
Message-ID: <4190202D.5010000@g-house.de>
Date: Tue, 09 Nov 2004 02:41:01 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de> <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org> <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <Pine.LNX.4.58.0411081656550.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411081656550.2301@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds schrieb:
> 
> So what I'd like you to do is to take the pre-PCI-merge tree, and see if 
> that works for you
> 
> 	# assuming a 2.6.10-rc1 tree
> 	bk undo -a1.2000.1.6
> 
> and if that works, then try the post-PCI-merge tree:
> 
> 	# assuming a 2.6.10-rc1 tree
> 	bk undo -a1.2000.1.7
> 
> (I just checked: the above numbers are actually valid even in the current
> -bk tree, so you don't have to first go to 2.6.10-rc1, you can just start 
> from a current tree)

thanks, Linus. i'll do all this tomorrow, see my other mail i just sent.
i'll definitely do all this 'cause i'm really curious about this thing.
(it's not even the need of sound any more. heck, i could just put in
another soundcard but that'd be too easy :)

> 
> Thanks for testing, and sorry for the confusion with the more recent PCI 
> merge.

doh, you can't image how thankful i am for your (and the other people's!)
help here. but don't waste too many cycles on this weird issue here. if it
does not break for a million users out there now - why bother at all?
perhaps it'll break later on but then we have the lkml-archives and
someone will eventually remember this thing. but no, i don't want to
discourage anyone here ;-)

regards,
Christian.
- --
BOFH excuse #19:

floating point processor overflow
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkCAs+A7rjkF8z0wRAu2pAKDBw1Cj3fFBXbtbkpfagkpgbxiK+ACcC2gn
HXmcjnhFFX8vAjK0IawPQgI=
=T1C6
-----END PGP SIGNATURE-----
