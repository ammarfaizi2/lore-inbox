Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160388AbQG0Rgd>; Thu, 27 Jul 2000 13:36:33 -0400
Received: by vger.rutgers.edu id <S160382AbQG0Rfj>; Thu, 27 Jul 2000 13:35:39 -0400
Received: from mail.turbolinux.com ([38.170.88.25]:4465 "EHLO mail.turbolinux.com") by vger.rutgers.edu with ESMTP id <S160398AbQG0Re0>; Thu, 27 Jul 2000 13:34:26 -0400
Date: Thu, 27 Jul 2000 10:52:36 -0700 (PDT)
From: "Matt D. Robinson" <yakker@turbolinux.com>
To: linux-kernel@vger.rutgers.edu
Subject: ANNOUNCE: Linux Kernel Crash Dumps (LKCD) 2.0 Available
In-Reply-To: <Pine.LNX.4.10.10007271026330.2939-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0007271039150.23130-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

The 2.0 version of the Linux Kernel Crash Dumps (LKCD) project is now
available -- this version applies to 2.3.99-pre9 kernels, and includes
some of Stephen Tweedie's patches for kiobufs (since we need them).

LKCD provides systems with the ability to save a system crash dump when
the kernel has a panic or exception, and saves the memory to your swap
space, recovering it on reboot, and creating a crash dump report which
can be sent to support personnel (or groups like 'lkml', if necessary).

Feel free to download our current patch from:

	http://oss.sgi.com/projects/lkcd/download/2.0

You can also look at and contribute to the source project on SourceForge.
The project's CVS location is at:

	http://cvs.sourceforge.net/cgi-bin/cvsweb.cgi/?cvsroot=lkcd

And as always, information about LKCD, including news, an FAQ, etc.,
can be found at:

	http://oss.sgi.com/projects/lkcd/

A few points to note:

- The x86 version works great, but we're still working on the Alpha and
  IA-64 ports.  They're coming along, however ... keep reading the LKCD
  News page for updates.  Thanks to Brian Hall for his help with the
  Alpha port.

- While you can build the vmdump code as a *module*, and it works, for now
  just build the vmdump code directly into the kernel -- the reason is
  because we still have to build the ability to perform stack traces when
  the code goes through a module.  (And that will take some time to
  complete, as it's kind of ugly to do ...)

- We are no longer limited to SCSI devices, like we were with the 2.2 
  kernel version.  We're going to try to backport the 2.3 changes into
  2.2, so we have a universal version.

If you have any other questions, please send me an E-mail, or review
the FAQ on the oss.sgi.com web site.  Thanks.

--Matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
