Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314600AbSEYOAt>; Sat, 25 May 2002 10:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSEYOAs>; Sat, 25 May 2002 10:00:48 -0400
Received: from host217-41-45-117.in-addr.btopenworld.com ([217.41.45.117]:47121
	"EHLO ambassador.mathewson.int") by vger.kernel.org with ESMTP
	id <S314600AbSEYOAs>; Sat, 25 May 2002 10:00:48 -0400
Subject: Re: isofs unhide option:  troubles with Wine
To: linux-kernel@vger.kernel.org
From: Joseph Mathewson <joe@mathewson.co.uk>
Reply-to: joe.mathewson@btinternet.com
Date: Sat, 25 May 2002 15:01:42 +0100
Message-Id: <TiM$20020525030142$2365@deschutes.mathewson.int>
X-Mailer: TiM infinity-ALPHA6.1a
X-TiM-Client: deschutes.mathewson.int [10.0.1.2]
In-Reply-To: <1022334596.1262.6.camel@jwhiteh>
Cc: Jeremy White <jwhite@codeweavers.com>
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message "Re: isofs unhide option:  troubles with Wine", <Jeremy White>
wrote:

> > >     1.  Invert the logic of the option, make it 'hide' instead
> > >         of unhide, and so unhide is the default.
> > 
> > how about:
> > 
> > /dev/hdb /cdrom iso9660 defaults,ro,unhide,user 0 2
> > 
> > in your /etc/fstab. This would allow users to mount and unmount CDs.
> > It also changes the default to unhide.
> 
> Yes, that is what we have to do now.  So, when our product is
> installed, a user is presented with a confusing, and highly technical
> question, the gist of which is:  please give us your root password
> so we can do something you don't understand.  It's okay, trust us,
> really...<grin>
> 
> Further, I would argue that if you accept that unhide is a
> reasonable default for me to force into the fstab, then
> it is a reasonable default for the kernel to have.

Is this not an issue that could be put to RedHat/Mandrake/SuSE/Turbo/etc to
include the above fstab in their standard install.  If the user is going to have
to upgrade their kernel to get this default, they will understand fstab.  If
they do not understand fstab, they are going to upgrade their kernel by
upgrading their distro anyway.  So why not push for this option in the default
fstab of popular distros?

Joe.
