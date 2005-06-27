Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVF0GCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVF0GCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVF0GBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:01:52 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:51460 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261851AbVF0F6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:58:00 -0400
Message-ID: <42BF9562.4090602@slaphack.com>
Date: Mon, 27 Jun 2005 00:57:54 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu>            <42BF8F42.7030308@slaphack.com> <200506270541.j5R5fULX007282@turing-police.cc.vt.edu>
In-Reply-To: <200506270541.j5R5fULX007282@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 27 Jun 2005 00:31:46 CDT, David Masover said:
> 
> 
>>*If* we decide that this must go both ways, *then* we either turn off
>>write support inside the zipfile
> 
> 
> Oh, *that* will do wonders for command symmetry.  And you just shot down
> the whole 'mv foo bar' being equivalent to 'zip bar foo' concept. ;)

In one of three possible settings for the imaginary zipfile plugin, yes.
 But if we're talking about a kernel source tree, how many of us
actually build zipfiles/tarballs of their kernel source trees, rather
than unpack existing ones?

>>                                 and do "make" with a symlink farm (cp
>>- -as isn't hard), or (better) we can set things up so that only on access
>>(most likely a read) of the original zipfile do we re-add all the changes.
> 
> 
> Those chuckleheads who have filled up a disk by saying 'tar cvf foo.tar .' just
> got a whole new way to fill the disk... ;)

Just a new interface :P

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+VYngHNmZLgCUhAQK/bQ/+MbWZrE+sg3te+YWCajaZhsZLyM4CZrGe
BrvUb3dLSKLLg+2CzsKXQp9u3bavJg7OEEmnzgY4dK3FaOHZSATzbwmRgi1hYtfe
TfVWKQb4z93zzS6MXafRkgL98qEIUV4n0aFKIEzDgeXAwMYx+Gv5Q7YMky7DEBNq
HV5ZiKxhsqCEJdsUKo80G2R12XBm9reunJM/xRt+iA7WfsevBi+/Fl7qbAIDG+sd
t83kZHiHQROTEmyyMj4zsJ0j7gRkJsXWKng3HEMl08AkRBIZxQRx0xmzWyZEs+wW
AaPPFvsFo04tfwplasvwZ7EcLoCgFP2rfnjx190wov6ZvEWwIbKepsyLqusEuRcR
hY0ohrWzYmQkHDXxs4FW+/QMsDF0L7YojHJgHOI1xSeCMOEgGPmHG9Jmf9FeK97Q
4xBXLDGXjlcDBZvDZciLzJCloH3pb+3TrzSkbIkTGnGbgtsS46bWRUAFOY1d2ynM
C1FTebc5LPGoDetsu9/cLLuJrCJbbmpN/AWR33WUOnu9/O+H0lWNhiYyOg0x2G/z
p6toqr95RPKO6tC5OliU7GfEpqjDhr+RQkjSUbrHqoNjZp3P07nCwGCfwMTCdsBx
AkpQyuyfn/RfZvaFOnpUSOTKCWfZKYB2/J8ij+FH8tcPpYl5uzb6H6mHNyEPlvAa
DOlFJixKQ7o=
=6LFS
-----END PGP SIGNATURE-----
