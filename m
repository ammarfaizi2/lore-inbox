Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLOG0d>; Fri, 15 Dec 2000 01:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOG0X>; Fri, 15 Dec 2000 01:26:23 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:49927 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129257AbQLOG0G>;
	Fri, 15 Dec 2000 01:26:06 -0500
Message-Id: <200012150704.CAA05020@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.35-2.4.0-test12
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Dec 2000 02:04:46 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.0-test12 is finally available.  It has been in CVS 
for a couple of days, but SourceForge only today fixed up the site enough to 
allow projects to make releases.

hostfs now mostly works. It's still somewhat buggy. It is also possible to 
specify what host directory you want mounted inside the virtual machine.

The problem with linking a profiling kernel was fixed. 

Several crashes were fixed. 

uname -m no longer returns 'um'.  It returns the underlying arch.  The reason 
for this is that some builds (not least the UML build itself) get confused 
when they see an 'um' machine.  I see no advantages to having UML returning a 
different arch, so it doesn't any more.

Several bugs in the block driver were fixed. 'dd if=ubd/0 of=/dev/null' no 
longer hangs, and dbench no longer produces filesystem corruption.

The project's home page is http://user-mode-linux.sourceforge.net

The project's download page is http://sourceforge.net/project/filelist.php?grou
p_id=429

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
