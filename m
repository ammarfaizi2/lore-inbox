Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSI0AzN>; Thu, 26 Sep 2002 20:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSI0AzN>; Thu, 26 Sep 2002 20:55:13 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:24705 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261593AbSI0AzM>;
	Thu, 26 Sep 2002 20:55:12 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Thu, 26 Sep 2002 18:00:23 -0700
User-Agent: KMail/1.4.7-cool
Cc: linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209261553.07593.ryan@completely.kicks-ass.org> <20020926235741.GC10551@think.thunk.org>
In-Reply-To: <20020926235741.GC10551@think.thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209261800.27582.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 26, 2002 16:57, Theodore Ts'o wrote:
> Wait a second.  These messages would occur only if you had done a
> read-only mount at 11:49:06.  Did you do a manual mount at that time?
> Do you have one or more filesystems in your /etc/fstab (in particular
> /dev/hda2) that are set to be mounted read-only? 
Only /dev/cdrom...

> That's the only
> thing that would explain the "write access enabled during recovery of
> readonly filesystem" warning message.  That message means that
> /dev/hda2 was readonly because the mount command *requested* that it
> be mounted read-only, not because of some error.
Would init remounting the filesystem read-only before a reboot explain that? 
11:49 is around the time I came to check my mail.

> How is your system configured vis-a-vis the /etc/fstab entry for
> /dev/hda2?
/dev/hda2       /               ext3            defaults,errors=remount-ro      
0       1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9k62rLGMzRzbJfbQRAlcSAKCMNMTRNN0D/T3GA7eM3HnzM9MVMgCfT1w6
V6JU4fqtHDN8pzsLSdo0mzw=
=kt7X
-----END PGP SIGNATURE-----
