Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSFIUYN>; Sun, 9 Jun 2002 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSFIUYM>; Sun, 9 Jun 2002 16:24:12 -0400
Received: from h24-80-217-227.gv.shawcable.net ([24.80.217.227]:30227 "EHLO
	mailwhore.wox.org") by vger.kernel.org with ESMTP
	id <S315171AbSFIUYL>; Sun, 9 Jun 2002 16:24:11 -0400
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Date: Sun, 9 Jun 2002 13:24:03 -0700
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.LNX.4.33.0206081849010.5464-100000@melchi.fuller.edu> <200206091158.43293.bodnar42@phalynx.dhs.org> <E17H8wh-0003ZO-00@starship>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200206091324.06694.bodnar42@phalynx.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On June 9, 2002 13:05, Daniel Phillips wrote:
> On Sunday 09 June 2002 20:58, Ryan Cumming wrote:
> > Shortcuts are very similar to .desktop files in KDE or Gnome. They
> > contain the location of their destination file, and possibly other
> > information, such as an icon. Win32 shortcuts are implemented at a higher
> > level than symbolic links in Unix; it's fairly easy to trick Notepad in
> > to editing shortcuts as text files.
> >
> > I would suggest that turning shortcuts in to symlinks should be disabled
> > by default. WINE actually cares about some of the shortcut information
> > beyond the destination file; turning the shortcut in to a symlink would
> > destroy that information.
>
> Thanks for that.  Yes, it seems shortcuts are not very much like symlinks.
> The question is: does the filesystem itself interpret them, or does the
> Windows shell?  If the latter, yes, I'd agree that it makes sense to handle
> them in Wine, not the filesystem.  The behaviour of MSDos running under
> Windows (I think ME was the last version that had one of those) can be used
> as an arbiter: if MSDos handles the shortcut, then it's a symlink and
> should be handled as such (that particular form of shortcut anyway).  If
> MSDos doesn't handle it then it's clear that linux vfat shouldn't either.

DOS won't interpret shortcuts. Shortcuts are almost entirely implemented in 
the Windows shell.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9A7lmLGMzRzbJfbQRAirqAJ4hawIEMoe7SWEn+k8BB1WjH1KLOQCeLFlP
DhI7oOuauSn+YUbgwE/vAPY=
=f4tR
-----END PGP SIGNATURE-----

