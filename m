Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292713AbSBUSyU>; Thu, 21 Feb 2002 13:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292714AbSBUSyJ>; Thu, 21 Feb 2002 13:54:09 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:36855 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292713AbSBUSx6>;
	Thu, 21 Feb 2002 13:53:58 -0500
Date: Thu, 21 Feb 2002 11:53:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
Message-ID: <20020221115330.J12832@lynx.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0202210011080.32476-100000@serv> <20020221125431.GB28759@codepoet.org> <3C74F46F.FEA6F63D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C74F46F.FEA6F63D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Feb 21, 2002 at 08:21:51AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 21, 2002  08:21 -0500, Jeff Garzik wrote:
> Erik Andersen wrote:
> > I like this.  It's simple, its clean, and it keeps all the
> > information in one spot.  I think we can go a bit farther here
> > and add in a list of the .c files that enabling this feature
> > should add to the Makefile (per the current
> >     obj-$(CONFIG_FOO)            += foo.o
> > stuff in the current Makefile).
> 
> Hey, you're skipping ahead to the cool chapters!
> 
> Seriously, yep, that's exactly where we eventually want to be:  all
> config, makefile, and help text info in one place.  To add a new net
> driver, I want to be able to simply add two files, driver.c and
> driver.conf, and be done with it.

...and have the Makefile/config tool slurp up "*.conf" from each directory
so you don't need to patch anything to add a new driver/fs/whatever that
doesn't patch external files...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

