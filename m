Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSIYXk2>; Wed, 25 Sep 2002 19:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSIYXk1>; Wed, 25 Sep 2002 19:40:27 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:5760 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261205AbSIYXk1>;
	Wed, 25 Sep 2002 19:40:27 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Wed, 25 Sep 2002 16:45:34 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <3D923E88.30104@pobox.com> <20020925232949.GA15765@think.thunk.org>
In-Reply-To: <20020925232949.GA15765@think.thunk.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209251645.40575.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 25, 2002 16:29, Theodore Ts'o wrote:
> There is also a 2.4.19 patch available as well:
>
> 	http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.4.19-2
>

I got some pretty nasty results with that patch. After enabling the dir_index 
superblock flag and running e2fsck -fD, the filesystem would spontaneously 
remount itself read-only (I have errors=remount-ro set) after a few minutes 
of use. Once I disabled dir_index, e2fsck picked up many duplicate blocks. 
There doesn't appear to be any severe filesystem damage, however.

- -Ryan 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9kkqkLGMzRzbJfbQRAiiSAJwLFZSyHkG9WSGw6HY23g6i+N+z0QCggQEF
ixJJJJLCe56O5lL51sTDgaE=
=sywJ
-----END PGP SIGNATURE-----
