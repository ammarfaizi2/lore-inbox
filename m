Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTJNLQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTJNLQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:16:50 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:158 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S262330AbTJNLQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:16:47 -0400
Date: Tue, 14 Oct 2003 21:16:39 +1000 (EST)
From: Michael Still <mikal@stillhq.com>
To: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, <linux-kernel@vger.kernel.org>
Subject: Re: make htmldocs
In-Reply-To: <20031014120946.A4969@beton.cybernet.src>
Message-ID: <Pine.LNX.4.44.0310142106220.16081-100000@diskbox.stillhq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, [iso-8859-2] Karel Kulhavý wrote:

> > > 2) How do I install DocBook stylesheets?
> > 
> > Depends on distribution.
> 
> How do I determine what distribution I have? I have compiled my whole system
> manually.

Then surely you have enough clue to do your own web surf for DocBook 
information. One way would be to randomly select a disto, and see what 
they install to make it work.

> Asking again: how do I install "DocBook stylesheets"?

Let's take the Debian example. The Makefiles state that I need db2html to 
convert to your chosen HTML format. db2html is provided by docbook-utils, 
which it would seems installs the files listed publically at:

http://packages.debian.org/cgi-bin/search_contents.pl?word=docbook-utils&searchmode=filelist&case=insensitive&version=unstable&arch=i386

Now, it turns out that docbook-utils is the name of the open source 
package, as well as the Debian package:

http://freshmeat.net/projects/docbook-utils/

So, I guess that tells you what to install.

> > > 3) Bugreport: there should be written
> > > "Linux kernel depends on DocBook stylesheets. You may download DocBook
> > > stylesheets here-and-there." in README
> > 
> > Depends on distribution. We also don't tell for every distribution
> > where to get gcc and how to install it.
> 
> Do you say that the place where DocBook stylesheet sources can be downloaded
> depends on distribution I have? I have been looking at their sourceforge
> project page but there is nothing like "download DocBook stylesheets".
> There are DocBook-dsssl and a ton of other cryptic packages but none of them
> is stylesheets.

Dude, he was just trying to ask what distro you use, in order to help you 
out. Of course how you install it changes based on the distro you're 
using.

> If there doesn't exist any distribution-idependent installation process
> for "DocBook stylesheets", then "DocBook stylesheets" is not portable,
> and transitively, "Linux Kernel" is not portable.

Given than most Linux distros are open source themselves, and that the 
documentation for many of them is open, perhaps we should all now take an 
opportunity to reflect on how non-sensical this statement is. Did you also 
consider that a bunch of this documentation is available pre-built on the 
web? For example, a bunch of the kernel API man pages can be found at:

http://www.stillhq.com/linux/mandocs/

> Could you please
> recommend me some other open-source free operating system where I don't
> need to have a "distribution" to be even able to read it's enclosed
> documentation? I have been using Linux Kernel for 7 years but can't anymore
> because I am unable to read it's manual.

FreeBSD? OpenBSD? NetBSD? Minix? I recommend you look through the list at 
http://mirror.aarnet.edu.au if you really feel the urge to move on.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson

