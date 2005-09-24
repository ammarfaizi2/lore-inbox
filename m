Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVIXRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVIXRpI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVIXRpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:45:08 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:36759 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932208AbVIXRpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:45:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=mnInkoV9tw+iGryD2vFaMW1+cykeaKIO/tgKkpjjCDsV3SGHKHekXkCsuOxupYaVjqWo/tRHLc2XLWe+0eDbdXsc7LfUMvq6iB2b3zAsOhqC8LYrQQThXvbrXZGm4iyNY4a8cVA1jqCfDnNf1XEknORauF0kh7nrdTwDuq8xbuA=
Message-ID: <4335909D.2070904@gmail.com>
Date: Sat, 24 Sep 2005 19:45:01 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: [BUG] alsa volume and settings not restored after suspend
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As topic.

Suspend works perfectly, but after resume, no sound from audio card.

i see application works, for example i see xmms equalizer working, but
no sound,
even if i change manually volume.

only way is restarting the alsa init script. after that it works
perfectly.
not a critical bug, but may be very confortable to have registers
setted properly.


Some infos:

kernel 2.6.14-rc2-git4
alsa compiled built-in
audio card: ens1370 (creative pci128)
init script: Gentoo default one.


ready to add more infos if needed.
and test any patch, of course.

Patrizio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDNZCcys6LZpyYQ6URAvJwAKCf4us21F8FBRrStfyaxhx2eRpCXACfbuso
siPbWKXGMmd8O66gXLx6iuw=
=CNcI
-----END PGP SIGNATURE-----

