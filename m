Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVDNTso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVDNTso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDNTso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:48:44 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:41922 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S261613AbVDNTqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:46:52 -0400
Message-ID: <425EC778.4070009@tin.it>
Date: Thu, 14 Apr 2005 14:41:44 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz> <425E9FE2.6090102@tin.it> <Pine.LNX.4.62.0504141050460.19663@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0504141050460.19663@qynat.qvtvafvgr.pbz>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBCF757B52D9BF98EFBCA5CDF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBCF757B52D9BF98EFBCA5CDF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Lang wrote:
> there are at least a half dozen options besides SMP that have similar 
> effects.

And of course if I take care of making them consistent... What I'd like 
is stability. Not in the sense of having a rock-stable kernel, that of 
course is already there. I'd like API stability, if API stability is 
achieved, ABI is there.

> Ok, now you are talking a distro, not linux itself. different subject, 
> belongs on different lists (and by the way distros already tend to do 
> this type of thing)

No. I have compiled everything from scratch, every single package. Now, 
every vanilla kernel brings the problem of recompiling modules for that 
particular version.

> first off, if you can deploy a new kernel across 100 machines you can 
> deploy new modules along with it.
> 
> second, if you are applying the patch and know that it doesn't affect 
> anything that the modules use you don't have to recompile the modules, 
> but if you want to be safe becouse you don't know what the patch affects 
> then you replace the modules as well (for all you know the patch affects 
> just a module, not the base kernel.

Applying a patch to 2.6.11 making it 2.6.12 brings one thing: all 
modules external to the vanilla kernel are no longer there and I have to 
recompile them every time...

> again you are talking about what a distro chooses to do, go ahead and do 
> this if you want, but it has no relevance to the kernel mailing list.
> 
> This will be my last message on this subject, hopefully you will let 
> this die or take the conversation to the mailing lists of the distros 
> that you choose to use.

The global feeling about kernel is that it seems that you don't care 
about the purpose of your task, which of course is not the kernel by 
itself. It can't be. It's about what it does (and already does it well), 
and what it provides to third-parties: the kernel and the API given to 
the outside world, since the kernel is not alone... and will never be of 
course! ;)

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enigBCF757B52D9BF98EFBCA5CDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXsd+4LBKhYmYotsRArBsAJ9ilDzsYllVnZk+DCoIYmsEz3LdUACfV312
mA1Pu7BzT87LIR3V0Ijm9OE=
=fHIb
-----END PGP SIGNATURE-----

--------------enigBCF757B52D9BF98EFBCA5CDF--
