Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285166AbSACJ3d>; Thu, 3 Jan 2002 04:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbSACJ3Z>; Thu, 3 Jan 2002 04:29:25 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:11904 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S285166AbSACJ3Q>;
	Thu, 3 Jan 2002 04:29:16 -0500
Date: Thu, 3 Jan 2002 04:29:12 -0500
From: lkml@ohdarn.net
Message-Id: <200201030929.g039TCZ02342@ohdarn.net>
To: linux-kernel@vger.kernel.org
Subject: Second edition of the -mjc branch has been released
Cc: lkml@ohdarn.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performance and stability issues have been fixed to some degree.
A lot of the patches I have received either did not have names attached
or I was unable to locate a name.  Please contact me if changes must
be made.  All of the patches that have been included in this release can
be found at:
	ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/included/mjc2
The release itself is located here:
	ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/current

Below is a snippet from Changelog.mjc:
mjc2:
Reverse Mapping Patch #10                       (Rik van Riel)
Bootmem patch                                   (William Lee Irwin III)
entry.S speedups                                (Alex Khripin)
-fixed entry.S to apply to mjc tree             (Luuk van der Duim)
NFS Updates                                     (Trond Myklebust)
kmem_cache_estimate optimization                (Balbir Singh)
IRQrate                                         (Ingo Molnar)
Pagecache & Icache hash changes                 (Chuck Lever,
                                                William Lee Irwin III,
                                                Rusty Russell,
                                                Anton Blanchard)
Voodoo Framebuffer Fixes                        (Jurriaan)
SiS 5513 Fixes                                  (Lionel Bouton)
ATI Rage128 Framebuffer Fixes                   (?)

removed in mjc2:
Software Suspend        (does not function correctly,
                         very poor style in some areas)
Lock-Break              (known to cause problems with other modules)


------
Michael Cohen
OhDarn.net
