Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTJNOJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTJNOJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:09:52 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:16769 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262353AbTJNOJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:09:48 -0400
Date: Tue, 14 Oct 2003 16:09:47 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Michael Still <mikal@stillhq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs
Message-ID: <20031014160947.A13499@beton.cybernet.src>
References: <20031014120946.A4969@beton.cybernet.src> <Pine.LNX.4.44.0310142106220.16081-100000@diskbox.stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0310142106220.16081-100000@diskbox.stillhq.com>; from mikal@stillhq.com on Tue, Oct 14, 2003 at 09:16:39PM +1000
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's take the Debian example. The Makefiles state that I need db2html to 
> convert to your chosen HTML format. db2html is provided by docbook-utils, 
> which it would seems installs the files listed publically at:

Sorry I downloaded source and installed. No db2html emerged, just docbook2html.
Tried debian's patch for the source. The same.
Tried symlinking docbook2html to db2html:

make[1]: Entering directory `/home/clock/linux-2.4.22/Documentation/DocBook'
rm -rf wanbook
db2html wanbook.sgml
jw: Please specify at least one catalog

Sorry but your guide seems not to work.

Again, please tell me, how to compile Linux Kernel HTML Documentation.

Cl<

> 
> http://packages.debian.org/cgi-bin/search_contents.pl?word=docbook-utils&searchmode=filelist&case=insensitive&version=unstable&arch=i386
> 
> Now, it turns out that docbook-utils is the name of the open source 
> package, as well as the Debian package:
> 
> http://freshmeat.net/projects/docbook-utils/
> 
> So, I guess that tells you what to install.
> 
> > > > 3) Bugreport: there should be written
> > > > "Linux kernel depends on DocBook stylesheets. You may download DocBook
> > > > stylesheets here-and-there." in README
> > > 
> > > Depends on distribution. We also don't tell for every distribution
> > > where to get gcc and how to install it.
> > 
> > Do you say that the place where DocBook stylesheet sources can be downloaded
> > depends on distribution I have? I have been looking at their sourceforge
> > project page but there is nothing like "download DocBook stylesheets".
> > There are DocBook-dsssl and a ton of other cryptic packages but none of them
> > is stylesheets.
> 
> Dude, he was just trying to ask what distro you use, in order to help you 
> out. Of course how you install it changes based on the distro you're 
> using.
> 
> > If there doesn't exist any distribution-idependent installation process
> > for "DocBook stylesheets", then "DocBook stylesheets" is not portable,
> > and transitively, "Linux Kernel" is not portable.
> 
> Given than most Linux distros are open source themselves, and that the 
> documentation for many of them is open, perhaps we should all now take an 
> opportunity to reflect on how non-sensical this statement is. Did you also 
> consider that a bunch of this documentation is available pre-built on the 
> web? For example, a bunch of the kernel API man pages can be found at:
> 
> http://www.stillhq.com/linux/mandocs/
> 
> > Could you please
> > recommend me some other open-source free operating system where I don't
> > need to have a "distribution" to be even able to read it's enclosed
> > documentation? I have been using Linux Kernel for 7 years but can't anymore
> > because I am unable to read it's manual.
> 
> FreeBSD? OpenBSD? NetBSD? Minix? I recommend you look through the list at 
> http://mirror.aarnet.edu.au if you really feel the urge to move on.
> 
> Cheers,
> Mikal
> 
> -- 
> 
> Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
> http://www.stillhq.com            |  to achieve my many goals"
> UTC + 10                          |    -- Homer Simpson
> 
