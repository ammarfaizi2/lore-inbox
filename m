Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVCXDEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVCXDEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVCXDEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:04:06 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:13972 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261692AbVCXDDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:03:50 -0500
Message-ID: <42422E40.5080703@comcast.net>
Date: Wed, 23 Mar 2005 22:04:32 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Triffid Hunter <triffid_hunter@funkmunch.net>
CC: ubuntu-devel <ubuntu-devel@lists.ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: vfat broken in 2.6.10?
References: <4241E3EA.4080501@comcast.net> <42420858.8020404@funkmunch.net>
In-Reply-To: <42420858.8020404@funkmunch.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Triffid Hunter wrote:
> i've seen the same problems with a fat32 partition image after an
> unclean shutdown. reading certain files would cause the filesystem to
> spontaneously become read-only with error messages similar to the ones
> you list below.

Clean umount, not unclean.  Not even removing the device, no shutdown.
I'm not damaging the filesystem except by actually using it.

It's remniscent of using NTFS with "full read-write" under Linux, where
you have lots of damage afterwards even though you didn't do anything
nasty to damage it.

> 
> my solution was to copy all the files off, rename the offending
> directory, and copy the relevant files back. unfortunately i can't
> remove the "dead" folder, as attempting to remove it sets the filesystem
> read-only :(
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCQi5AhDd4aOud5P8RAiedAJ40CyoAYYdu1jbSnl1j8J7/iXH2dQCbBuND
uZX0j3qIZe3TYQ2NMMelgks=
=XMEH
-----END PGP SIGNATURE-----
