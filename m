Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSFMBui>; Wed, 12 Jun 2002 21:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSFMBuh>; Wed, 12 Jun 2002 21:50:37 -0400
Received: from 12-226-168-48.client.attbi.com ([12.226.168.48]:24201 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S317398AbSFMBug>; Wed, 12 Jun 2002 21:50:36 -0400
Date: Wed, 12 Jun 2002 21:50:14 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Cc: fgouget@free.fr
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-Id: <20020612215014.6c2aeaf6.kwall@kurtwerks.com>
In-Reply-To: <Pine.LNX.4.43.0206121735350.17355-100000@amboise.dolphin>
Organization: KurtWerks *Isn't* Organized
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Francois Gouget:
>
> On Tue, 11 Jun 2002, Albert D. Cahalan wrote:
> 
> > Francois Gouget writes:
> >
> > > This looks like a bad idea. The reason is that the VFAT driver is
> > > the wrong abstraction layer to support the '.lnk' files:
> > >
> > >  * on Windows if you open("foo.lnk") you get the .lnk file, not
> > >  the file
> > > it 'links' to. On Linux you would get the file it points to
> > > instead which is a different behavior.
> >
> > That's a common Windows app bug which exists exactly because
> > the Microsoft implementation is at the wrong abstraction layer.
> 
> No it is not a 'Windows app bug' bug. It is you who are mistaken
> because you persist in believing that .lnk files are or are meant to
> be symbolic links. They are not.
> 
> Unix has the exact equivalent to .lnk files. These are the '.dsektop'
> files used by KDE and Gnome (they even used to be called '.kdelnk'
> files in KDE 1).

These files *are not* Unix files in the sense that they have universally
understood or generally accepted semantics. They are artifacts of KDE and 
GNOME and the window managers I use do not know how to interpret them, 
except as plain vanilla text files.

Kurt
-- 
Canada Bill Jone's Motto:
	It's morally wrong to allow suckers to keep their money.

Supplement:
	A .44 magnum beats four aces.
