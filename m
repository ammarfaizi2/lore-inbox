Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130178AbRCCAMG>; Fri, 2 Mar 2001 19:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130179AbRCCAL4>; Fri, 2 Mar 2001 19:11:56 -0500
Received: from fast.cs.utah.edu ([155.99.212.1]:21009 "EHLO fast.cs.utah.edu")
	by vger.kernel.org with ESMTP id <S130178AbRCCALu>;
	Fri, 2 Mar 2001 19:11:50 -0500
Message-Id: <200103030011.RAA18893@mancos.cs.utah.edu>
From: Jay Lepreau <lepreau@cs.utah.edu>
To: smlong@teleport.com
cc: linux-kernel@vger.kernel.org
Subject: Generic x86 boot code [was Linux OS boilerplate]
Date: Fri, 02 Mar 2001 17:11:46 MST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I learned of this 12-days past discussion on the "kernel traffic" digest.

> The motivation behind this is that I would like to use the Linux boot
> system as a boilerplate booter for some experimental code. It's
> probably much cleaner and more robust than any boot loader I might
> come up with.

The Linux boot code may meet your needs fine, but especially if you
are developing a quite different kernel, you should take a look at the
OSKit, that we developed for the exact purpose of supporting
experimental operating systems without getting in your way.
    http://www.cs.utah.edu/flux/oskit/

It's easy to use, and all the booting is taken care of for you, comes
up in 32-bit mode, etc.  Provides Linux device drivers if you want
drivers, and has a large choice of other components, all separated
with no or minimal dependencies.  There is continuing work on it, both
research and development.

Let us know if you use it, and/or need some help here and there.

Jay Lepreau, University of Utah, http://www.cs.utah.edu/flux/
