Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266911AbUBSIHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266953AbUBSIHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:07:21 -0500
Received: from b075150.adsl.hansenet.de ([62.109.75.150]:23183 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S266911AbUBSIHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:07:19 -0500
Message-ID: <40346EAD.5010403@portrix.net>
Date: Thu, 19 Feb 2004 09:07:09 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?77+9?= <leandro@dutra.fastmail.fm>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <pan.2004.02.19.02.32.37.90698@dutra.fastmail.fm>
In-Reply-To: <pan.2004.02.19.02.32.37.90698@dutra.fastmail.fm>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD46A14152414480784897B1D"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD46A14152414480784897B1D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Leandro Guimarães Faria Corsetti Dutra wrote:
> On Mon, 19 Jan 2004 10:30:05 -0500, Theodore Ts'o wrote:
> 
> 
>>>On Sun, Jan 18, 2004 at 11:27:54AM +0100, Jan Dittmer wrote:
>>>
>>>>EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory
>>>>#9783034: rec_len % 4 != 0 - offset=0, inode=1846971784,
>>>>rec_len=33046, name_len=154
>>>>Aborting journal on device dm-1.
>>>>ext3_abort called.
>>>>EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted
>>>>journal Remounting filesystem read-only
> 
> 
> 	Has this been resolved?  I have a machine due to enter production, am
> considering going back to 2.4 if there is no further information.
> 
> 

I haven't tried it with 2.6 since this incident. But considering that 
the machine in question crashed a couple of times afterwards, it may 
well be, that a hardware fault caused this initially. But I simply don't 
dare to put 2.6 again on this machine as I've no real backup of most of 
the data, and restoring some 100 gb from cds is really annoying.

Jan

--------------enigD46A14152414480784897B1D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFANG6zLqMJRclVKIYRAiBIAJ46FIewccuvhxjKye92kAGKfNLwzwCeIphM
A4Is3lIqzFWDGzWjcl+I67Y=
=6zme
-----END PGP SIGNATURE-----

--------------enigD46A14152414480784897B1D--
