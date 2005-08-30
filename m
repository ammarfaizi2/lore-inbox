Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVH3Wlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVH3Wlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVH3Wlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:41:51 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:15608 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932261AbVH3Wlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:41:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:openpgp:content-type:content-transfer-encoding:from;
        b=VfkIiSFH4OL43a0Nzy+Su1ugfrK+EAYAdd++NHS18MS0lHI7pdjqB40JPonge1MRScC3vC0sJhAf5d4kiIkUlMSB4wr09XJA5qHKIAoDsmZj3S60I6owEg1NKHohPqKP4ve5uKzUtLBM7alJAB13VguOLqjNrpKCIZ32UYD0n30=
Message-ID: <4314E0AA.5070809@gmail.com>
Date: Wed, 31 Aug 2005 00:41:46 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050826)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 and the IRQs
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=08FA3507;
	url=hpk://subkeys.pgp.net
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Stephan Grein <stephan.grein@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi, i updated my laptop to 2.6.13 vanilla kernel.
When i booted up it gave me some strange irq messages (debug) which
showed not up on 2.6.12.2 vanilla. I added irqpoll to lilo.conf, and
it removed some output. However before i did add irqpoll to lilo my
pcmcia cards worked also, after adding also.
Here is the output, maybe you can help me. (I did not change .config
from 2.6.12.2 to 2.6.13, just did a make oldconfig.)
cheers.

- --
Stephan 'hagbard' Grein, <Stephan.Grein@gmail.com>
http://hagbard.ninth-art.de/
GnuPG-Key-ID: 0x08FA3507
<ESC> :wq
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDFOCqDkIR3wj6NQcRAp6EAJ488ey6G9t7udo9j/eE1sDDJBQSUwCfYzoV
4GhoE3bF8iLxHKdVuGLOit0=
=NY57
-----END PGP SIGNATURE-----

