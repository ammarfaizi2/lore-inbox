Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSIZTyy>; Thu, 26 Sep 2002 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261496AbSIZTyy>; Thu, 26 Sep 2002 15:54:54 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:37760 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261495AbSIZTyx>;
	Thu, 26 Sep 2002 15:54:53 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Thu, 26 Sep 2002 12:59:39 -0700
User-Agent: KMail/1.4.7-cool
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <200209261951.g8QJpn0t013428@pincoya.inf.utfsm.cl>
In-Reply-To: <200209261951.g8QJpn0t013428@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209261259.49258.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 26, 2002 12:51, Horst von Brand wrote:
> > The interesting fsck errors this time were:
> > 245782 was part of the orphaned inode list FIXED
> > 245792 was part of the orphaned inode list FIXED
> > 245797...
> >
> > 245782,245792 don't exist according to ncheck.
>
> Old(ish) WD disk, perhaps PIIX IDE? At home I get filesystem corruption if
> DMA is enabled...

No, 40GB Maxtor, VT133A chipset. This box has experienced -zero- filesystem 
corruption since it was purchased, up until I tried the directory index 
patch. And even then, it only shows up with the dir_index flag set.

OTOH, much of this corruption could be because journal replay doesn't seem to 
be happening after a filesystem is remounted read-only due to errors. That 
would certainly leave the filesystem in an inconsistant state.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9k2c0LGMzRzbJfbQRAt5lAJ4mSPUgX3EPDsvzLnS0f768Rc51nwCfUpdk
ZSt7Q/WjmA1kyPF/C9DS4Nc=
=6uMQ
-----END PGP SIGNATURE-----
