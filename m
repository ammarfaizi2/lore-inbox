Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312968AbSCZHsk>; Tue, 26 Mar 2002 02:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312969AbSCZHsb>; Tue, 26 Mar 2002 02:48:31 -0500
Received: from ns.suse.de ([213.95.15.193]:36364 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312968AbSCZHsS>;
	Tue, 26 Mar 2002 02:48:18 -0500
To: Brian S Queen <bqueen@nas.nasa.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dnotify header question
In-Reply-To: <200203251817.KAA04773@octane12.nas.nasa.gov>
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 26 Mar 2002 08:48:16 +0100
Message-ID: <hoit7jepmn.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian S Queen <bqueen@nas.nasa.gov> writes:

> I apologize if this is a repeat question.  I didn't see my own question
> come by on the mailing list though.
>
> I have been wondering how to get the new dnotify parts currently in
> <linux/fcntl.h> into <fcntl.h>.  I have recompiled and entirley rebuilt
> gcc with the --with-headers option in an effort to get it to
> incorporate the new stuff from <linux/fcntl.h>.  Is this an false
> expectation?  Do I have to submit the changes to the glibc folks to get
> them into the <fcntl.h>?

Update your glibc.  The fixes are already in <bits/fcntl.h> since
september 2000, I'm appending the relevant ChangeLog entries.

Andreas

2000-09-29  Andreas Jaeger  <aj@suse.de>

	* sysdeps/unix/sysv/linux/arm/bits/fcntl.h: Protect DN_* by
	__USE_GNU.
	* sysdeps/unix/sysv/linux/ia64/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/m68k/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/mips/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/s390/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/sparc/bits/fcntl.h: Likewise.

2000-09-29  Andreas Jaeger  <aj@suse.de>

	* sysdeps/unix/sysv/linux/arm/bits/fcntl.h: Synch with Linux
	2.4.0-test9-pre7.
	* sysdeps/unix/sysv/linux/ia64/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/m68k/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/mips/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/s390/bits/fcntl.h: Likewise.
	* sysdeps/unix/sysv/linux/sparc/bits/fcntl.h: Likewise.


-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
