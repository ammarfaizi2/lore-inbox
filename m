Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVF0P2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVF0P2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVF0PYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:24:54 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:7943 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261773AbVF0PIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:08:32 -0400
Message-ID: <42C0166C.4090000@slaphack.com>
Date: Mon, 27 Jun 2005 10:08:28 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu> <42BF8F42.7030308@slaphack.com> <200506270541.j5R5fULX007282@turing-police.cc.vt.edu> <42BF9562.4090602@slaphack.com> <200506270612.j5R6CZGX008462@turing-police.cc.vt.edu> <42BF9C4D.3080800@slaphack.com> <200506270643.j5R6hqRh009781@turing-police.cc.vt.edu> <42BFA421.70506@slaphack.com> <20050627134752.GE16867@khan.acc.umu.se>
In-Reply-To: <20050627134752.GE16867@khan.acc.umu.se>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Weinehall wrote:
> On Mon, Jun 27, 2005 at 02:00:49AM -0500, David Masover wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Valdis.Kletnieks@vt.edu wrote:
>>
>>>On Mon, 27 Jun 2005 01:27:25 CDT, David Masover said:
>>
>>[...]
>>
>>
>>>>Speaking of backup, that's another nice place for a plugin.  Imagine a
>>>>dump that didn't have to be of the entire FS, but rather an arbitrary
>>>>tree...  That might be a nice new archive format.  I know Apple already
>>>>uses something like this for their dmg packages.
>>>
>>>
>>>Hmm.. you mean like 'tar' or 'cpio' or 'pax' or 'rsync'? :) 
>>
>>No, a dmg is an OS X program installer.  It appears to be a disk image
>>of sorts.  So this is the backup idea in reverse.
> 
> 
> Yeah, disk images are really a new invention...  It's not like creating
> an arbitrarily large solid file and then doing mkfs on it would
> accomplish the same thing =)

Scroll up a little...

"Imagine a dump that didn't have to be of the entire FS, but rather an
arbitrary tree..."

Such a dump might produce the same thing as mkfs would, but it would do
it faster, maybe even copy-on-write.

The OS X example is to point out that using some chunk of an FS as an
archive format isn't necessarily a bad idea.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsAWa3gHNmZLgCUhAQJnRw//Sh0L38YZ/1fuxjo1TXQtfpMs2YpOIwSm
brJtx53rJD8nvAnOP1rwtWc5RiIl+YDzlWIO31L+U45Ap4B9+M4f7elqOlXXyrhw
HC/PIu3kai+MZYV05As8IaQNlU7fDPygnYVfIdFzz1NfwwiRo7TPXjjoPlkwaN8w
SluYj9CtwTUarNc7Nqct4gmmoxZ20YuyTmpQLyYkU4UMFmGcUfokhg03WUaFPGZr
bJL5TjW4YePyFtPcU53JcztjLD2z5pQrj1QdzK5hE2FM0UAM+0mWVEalkR19bNk3
z/lLEkfWBHP3gib9mdC5RsT/aik8nwRdr6X80WtPEMPwqAgSN+7x37u8Jp3paqLc
iQu54zVb7h9GJQfoi7sRCfO3GXxRKm3HDB8RnLZD39RKq3duA9M5hN+X9hMYVjd7
KE8kH387QvhLH7TwlfCyIQ2yY6/9abw4Jw9kdoBcX1pq5HpSf1s9TreA/w+89gan
W5NoIMo9VPR6Lhx9h6f7O07kxqVNdpjgw6w1LAGmgXKtlT/ojZ3lunXXPsjKknWN
M11XYiG6wBRNWJKsWsbh19O9FdcjpNknCxvrSLdiQDD44BTqc7l+Kt6dhACiyigs
BBMG3ceowL+vh52spCkakksqCIU4fb6+ndv2g43Q0d2Sk9tpCFUakzEugGfXrHYR
0qNwqhqbe2o=
=lP7Z
-----END PGP SIGNATURE-----
