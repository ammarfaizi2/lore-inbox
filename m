Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSFMC53>; Wed, 12 Jun 2002 22:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSFMC52>; Wed, 12 Jun 2002 22:57:28 -0400
Received: from 12-226-168-48.client.attbi.com ([12.226.168.48]:37769 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S317427AbSFMC51>; Wed, 12 Jun 2002 22:57:27 -0400
Date: Wed, 12 Jun 2002 22:57:02 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-Id: <20020612225702.34a887c1.kwall@kurtwerks.com>
In-Reply-To: <200206121942.56046.ryan@completely.kicks-ass.org>
Organization: KurtWerks *Isn't* Organized
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Ryan Cumming:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On June 12, 2002 19:25, Kurt Wall wrote:
> > That's *precisely* the point I tried to make. .desktop files are
> > just plain text files, as far as Unix is concerned. They do not map
> > neatly to Windows .lnk files because the kernel's file system layer
> > does not handle them specially, as it does symlinks. God and Bill
> > Gates alone know how Windows handles .lnk files, but it does seem
> > that Windows imputes to them special semantics, rather like a shell
> > script.
> 
> No, some people actually know how Windows works. The kernel has very
> little to do with .lnk files, and in fact it sees them as regular
> files. If you run "notepad foo.lnk", you will see the link's binary
> contents. If you use the CreateFile or OpenFile kernel calls, you will
> get a file handle pointing to the link's contents. If you attempt to
> execute a .lnk file from the command line or using CreateProcess, it
> will horribly fail.
> 
> In fact, to dereference a link in userspace, you must open the .lnk
> file, examine its contents with a library call, and then open the
> destination file.  This is extremely similar to how Gnome or KDE
> handle .desktop files: mainly in the shell.

Okay. I readily admit that I do not know how Windows works. 
I stand corrected.

Kurt
-- 
Happiness, n.:
	An agreeable sensation arising from contemplating the misery of
another.
		-- Ambrose Bierce, "The Devil's Dictionary"
