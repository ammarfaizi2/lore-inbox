Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUA1LGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUA1LGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:06:15 -0500
Received: from c215027.adsl.hansenet.de ([213.39.215.27]:2441 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S265902AbUA1LGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:06:11 -0500
Message-ID: <4017979F.4050105@portrix.net>
Date: Wed, 28 Jan 2004 12:06:07 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org>
In-Reply-To: <20040127190813.GC22933@thunk.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEBEE56AAC3BF0DE6CFB34BE5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBEE56AAC3BF0DE6CFB34BE5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Theodore Ts'o wrote:
> On Fri, Jan 23, 2004 at 09:22:25AM +0100, Jan Dittmer wrote:
> 
>>Okay, I fscked all filesystems in single user mode, thereby fscked up my 
>>root filesystem, though I didn't even check it - so I restored it from 
>>backup (grub wouldn't even load anymore).
> 
> 
> What messages were printed by e2fsck while it was running --- and was
> all of the filesystems unmounted, excepted for the root filesystem,
> which should have been mounted read-only?
> 
> 
>>After 2 days in my freshly setup debian (2.6.1-bk6), same error. But 
>>this time at least I know it's because I tried to delete those files in 
>>the lost+found directory...
> 
> 
> How did you come to that conclusion?

Argh, sorry, after chattr -aI the files could be deleted. sorry for the 
noise.

Jan

--------------enigEBEE56AAC3BF0DE6CFB34BE5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAF5efLqMJRclVKIYRAraGAJ4huRqFsWD5tSPwdnOpRWmSsSzc0wCfVn/d
0oZp7qf16iGd0C65fmLm4hg=
=sXC5
-----END PGP SIGNATURE-----

--------------enigEBEE56AAC3BF0DE6CFB34BE5--
