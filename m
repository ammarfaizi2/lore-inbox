Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSFJAFD>; Sun, 9 Jun 2002 20:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSFJAFC>; Sun, 9 Jun 2002 20:05:02 -0400
Received: from melchi.fuller.edu ([65.118.138.13]:32017 "EHLO
	melchi.fuller.edu") by vger.kernel.org with ESMTP
	id <S315379AbSFJAFB>; Sun, 9 Jun 2002 20:05:01 -0400
Date: Sun, 9 Jun 2002 17:04:12 -0700 (PDT)
From: <christoph@lameter.com>
X-X-Sender: <christoph@melchi.fuller.edu>
To: Nicholas Miell <nmiell@attbi.com>
cc: Thunder from the hill <thunder@ngforever.de>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        <linux-kernel@vger.kernel.org>, <adelton@fi.muni.cz>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <1023663819.1511.35.camel@entropy>
Message-ID: <Pine.LNX.4.33.0206091702160.18945-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2002, Nicholas Miell wrote:

> Yeah, and it uses the native IShellLink COM interface to do it, which
> guarantees future (Windows) compatibility. Misusing the comment field to
> store the path is a bit questionable, though.

The format is standardized. See the orginal readme by Jan.

> Actually, if people are so hell-bent on making symlinks work on VFAT,
> I'd suggest that they make a LD_PRELOAD'd shared library that intercepts
> the open, lstat, symlink, etc. calls and Does The Right Thing on VFAT
> filesystems. Much cleaner than putting it in the kernel or in all the
> apps that might be used on a VFAT filesystem.

Yuck that could potentially mess up all sorts of other things. Why is it
so difficult to just do it the easy way. .lnk files on linux and other
fses do not make much sense. On vfat it does.


