Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSFMC1K>; Wed, 12 Jun 2002 22:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317414AbSFMC1J>; Wed, 12 Jun 2002 22:27:09 -0400
Received: from 12-226-168-48.client.attbi.com ([12.226.168.48]:31625 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S317415AbSFMC0E>; Wed, 12 Jun 2002 22:26:04 -0400
Date: Wed, 12 Jun 2002 22:25:40 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-Id: <20020612222540.23e38e0a.kwall@kurtwerks.com>
In-Reply-To: <Pine.GSO.4.21.0206122152300.16357-100000@weyl.math.psu.edu>
Organization: KurtWerks *Isn't* Organized
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Alexander Viro:
>
> On Wed, 12 Jun 2002, Kurt Wall wrote:
> 
> > > Unix has the exact equivalent to .lnk files. These are the
> > > '.dsektop' files used by KDE and Gnome (they even used to be
> > > called '.kdelnk' files in KDE 1).
> > 
> > These files *are not* Unix files in the sense that they have
> > universally understood or generally accepted semantics. They are
> > artifacts of KDE and 
> 
> What the hell do you mean "these files are not Unix files"???  They do
> have universally understood semantics - persistent named array of
> characters. That's what Unix files _are_.

That's *precisely* the point I tried to make. .desktop files are just
plain text files, as far as Unix is concerned. They do not map neatly
to Windows .lnk files because the kernel's file system layer does
not handle them specially, as it does symlinks. God and Bill Gates
alone know how Windows handles .lnk files, but it does seem that Windows
imputes to them special semantics, rather like a shell script.

> > GNOME and the window managers I use do not know how to interpret
> > them, except as plain vanilla text files.
> 
> Yes, and...?  From what I've seen in this thread that's precisely what
> these .lnk files are in Windows.  You would have a point if Windows
> kernel would handle them as Unix kernel handles symlinks.  It doesn't.

Again, that was my point, which I rather muddled. I was coming at it from 
the other direction, though. Windows doesn't handle .lnks as the Unix kernel
handles symlinks, true, but the kernel doesn't handle .desktop files as
Windows handles .lnks, either.

> Some libraries know how to parse them.  Which means "plain files", no
> matter how you turn it.

Quite so: the kernel sees .desktop and sees a plain old file; Windows sees
.lnk and does something that resembles interpreting them. Again, my point
was that .desktop files do not map cleanly .lnk files.

As for who "wins" in this thread, I could care less because I don't need
or want to display Windows shortcuts.

Kurt
-- 
Pity the meek, for they shall inherit the earth.
		-- Don Marquis
