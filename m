Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSFJHj6>; Mon, 10 Jun 2002 03:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSFJHj5>; Mon, 10 Jun 2002 03:39:57 -0400
Received: from host217-41-51-65.in-addr.btopenworld.com ([217.41.51.65]:19217
	"EHLO ambassador.mathewson.int") by vger.kernel.org with ESMTP
	id <S316728AbSFJHj4>; Mon, 10 Jun 2002 03:39:56 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
To: linux-kernel@vger.kernel.org
From: Joseph Mathewson <joe@mathewson.co.uk>
Reply-to: joe.mathewson@btinternet.com
Date: Mon, 10 Jun 2002 08:42:03 +0100
Message-Id: <TiM$20020610084203$1595@fusion.mathewson.int>
X-Mailer: TiM infinity-ALPHA6.1b
X-TiM-Client: fusion.mathewson.int [10.0.1.1]
In-Reply-To: <Pine.LNX.4.33.0206091502580.17808-100000@melchi.fuller.edu>
Cc: christoph@lameter.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message "Re: vfat patch for shortcut display as symlinks for 2.4.18",
<<christoph@lameter.com>> wrote:

> > One can also live with "foo.lnk". (It's much easier and
> saner, too.)
> 
> No one cannot untar a source tarball with symlinks in a vfat fs without
> the patch. We cannot live with foo.lnk. Its insane not to carry over the
> semantics as much as possible.

Does the proposed patch give full symlink support or does it just read .lnk
files?  Most source tarballs will not have .lnk files in them, they will have
symlinks.  Would tar create the .lnk files if it was extracting to vfat?  If the
patch gives symlink support in some other way than .lnk files, why can't we just
use that and not meddle with reading the .lnk files to allow Linux to run in a
vfat partition.

> vfat is the only fs that can be shared between microsoft oses and linux.
> umsdos mangles filenames and does other ugly things. umsdos is an example
> of what not to do with a fs. umsdos is a hack. vfat+symlinks is the
> completion of an implementation.

This is why I think MS will (and are) killing FAT 32 as quickly as they can (the
last properly understood MS filesystem...).  To really entice users from Windows
in the future, this kind of patch is going to have to work on NTFS, not FAT. 
Now that the NT codebase is the "home" codebase as well (with the advent of XP),
NTFS is going to take massive inroads into FAT's market share.  And there have
been rumours for a while that MS SQL Server is going to form the basis of the
next MS filesystem.
 
Joe.

+-------------------------------------------------+
| Joseph Mathewson <joe@mathewson.co.uk>          |
+-------------------------------------------------+
