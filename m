Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTLDIZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 03:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTLDIZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 03:25:40 -0500
Received: from guardian.hermes.si ([193.77.5.150]:18703 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S263290AbTLDIZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 03:25:38 -0500
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC0471@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: "'Mikael Pettersson'" <mikpe@csd.uu.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Bugs in linux-2.6.0-test11/README
Date: Thu, 4 Dec 2003 09:25:26 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Balazic writes:
>  > 2.6.0-test11/README says :
>  > 
>  >  If you want
>  >    to make a boot disk (without root filesystem or LILO), insert a
> floppy
>  >    in your A: drive, and do a "make bzdisk".
>  > 
>  > Wasn't that feature (booting without LILO or other boot loader )
> removed ?
>  > At least http://www.kniggit.net/wwol26.html says so.
> 
> Yes, but 'make bzdisk' was reimplemented to use a proper bootloader:
> syslinux. You'll need mtools and syslinux-2.06 or later.
> 
> I'm also using this approach with 2.4 kernels now, since it eliminates
> the annoying kernel size limitation of the old built-in loader.
> 
>  >    For some, this is on a floppy disk, in which case you can copy the
>  >    kernel bzImage file to /dev/fd0 to make a bootable floppy.
> 
> Straight copy won't work any more, that's a README bug.
> 
So, was my mail enough or should I report this issue(s) somewhere else.
mail address, bugzilla ?
I'll look into bugzilla.kernel.org and report it there, unless i'm told
otherwise.

Regards,
David
