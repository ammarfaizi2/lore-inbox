Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSFMCAf>; Wed, 12 Jun 2002 22:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSFMCAe>; Wed, 12 Jun 2002 22:00:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8126 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317399AbSFMCAe>;
	Wed, 12 Jun 2002 22:00:34 -0400
Date: Wed, 12 Jun 2002 22:00:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kurt Wall <kwall@kurtwerks.com>
cc: linux-kernel@vger.kernel.org, fgouget@free.fr
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <20020612215014.6c2aeaf6.kwall@kurtwerks.com>
Message-ID: <Pine.GSO.4.21.0206122152300.16357-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Kurt Wall wrote:

> > Unix has the exact equivalent to .lnk files. These are the '.dsektop'
> > files used by KDE and Gnome (they even used to be called '.kdelnk'
> > files in KDE 1).
> 
> These files *are not* Unix files in the sense that they have universally
> understood or generally accepted semantics. They are artifacts of KDE and 

What the hell do you mean "these files are not Unix files"???  They do
have universally understood semantics - persistent named array of characters.
That's what Unix files _are_.

> GNOME and the window managers I use do not know how to interpret them, 
> except as plain vanilla text files.

Yes, and...?  From what I've seen in this thread that's precisely what
these .lnk files are in Windows.  You would have a point if Windows
kernel would handle them as Unix kernel handles symlinks.  It doesn't.
Some libraries know how to parse them.  Which means "plain files", no
matter how you turn it.

