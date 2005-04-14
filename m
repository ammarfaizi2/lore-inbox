Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVDNWvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVDNWvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVDNWvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:51:22 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:63899 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S261622AbVDNWvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:51:00 -0400
Message-ID: <425EF2A3.1070007@tin.it>
Date: Thu, 14 Apr 2005 17:45:55 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: David Lang <dlang@digitalinsight.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <200504142034.j3EKYqmS005113@laptop11.inf.utfsm.cl>
In-Reply-To: <200504142034.j3EKYqmS005113@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig89AACFC4BF2B7F58D8CE564E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig89AACFC4BF2B7F58D8CE564E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Horst von Brand wrote:
>>No I'm not confusing. As long as the .config has an influence on the 
>>makefiles I get different symbols names.
> 
> Nope.

I don't understand. The .config drives the kernel build, I don't get XFS 
functions and names if I don't compile it. I have different symbol 
names... At least, that's what I understand... and that's what 
happens... Never the same names on different kernels.

> And kernels compiled with one compiler are different than those compiled
> with another. And if you have preemption they are different. Don't forget
> about clasic i386 vs i486 vs ... vs i686 (spinlocks generate different
> code!). Then let's consider memory split: 2/2, 3/1, 3.5/0.5, ... Now throw
> in assorted debugging options. On some architectures you have several
> possible (reasonable!) page sizes.

Yes, ok.

> Define "simple environment". Even Red Hat (they are /very/ interested in a
> single kernel image, as it cuts down testing and bug tracking etc!) ships
> half a dozen different kernels, tailored for different configurations. And
> you'll find external modules (like for NTFS) compiled separately for each
> of them.

Yes, but as long as you keep with the same configuration, no problem 
should arise in changing the kernel version.

> Or having /your/ standard kernel on all 100 machines, compile once and copy
> around. No need for /me/ to run your exact same configuration.

I probably expressed myself badly. I don't mean anyone having the same 
configuration... why on earth should it be?

>>Source compatibility is there.
> 
> Sort of.

I hope! :)

> And A doesn't have some options I'd like, and others you loathe.

That's why you recompile, but why should you throw your other modules 
not included in the kernel release?

>>             creating the kernel with additions and patches, and 
>>distributing them. Modules .A should work on .B,
> 
> Iff nothing changes. That isn't usually the case.

That's weird... why should things really change so drastically if the 
external interface still remains the same? It's probably a matter of 
abstraction...

> The problem is that giving that guarantee costs developer time and
> flexibility. The gain (given that source for recompilation is freely
> available) is so minuscule that the consensus is that it just isn't worth
> any extra hassle /at all/.

Ok.

> And the decision to design thusly is completely conscicious, it is not a
> random "it just turned out this way by mistake".
> 
>>I just see advantages on ABI, and I think it's not bad talking about it...
> 
> I see many disadvantages to ABI, and it wouldn't be bad to look at them too.

I'd really like to know... I'm naive? Yes :) Of course, other than 
``more work'', but technical disadvantages...

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig89AACFC4BF2B7F58D8CE564E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXvKm4LBKhYmYotsRAouoAJ46W3clMK7D9NgmJ/iYvhfhpX38PACfeLRf
gO8+yMQgxqyM57NbG/SxZrg=
=5Xam
-----END PGP SIGNATURE-----

--------------enig89AACFC4BF2B7F58D8CE564E--
