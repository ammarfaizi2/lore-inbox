Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRC0DwB>; Mon, 26 Mar 2001 22:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRC0Dvn>; Mon, 26 Mar 2001 22:51:43 -0500
Received: from viper.haque.net ([64.0.249.226]:3739 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S130471AbRC0Dvi>;
	Mon, 26 Mar 2001 22:51:38 -0500
Message-ID: <3AC00E1D.FF8477AF@haque.net>
Date: Mon, 26 Mar 2001 22:50:53 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Madden <jmadden@spock.shacknet.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <Pine.LNX.4.21.0103262125400.8769-100000@spock.shacknet.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Madden wrote:
> 
> On Mon, 26 Mar 2001, David E. Weekly wrote:
> 
> > On Linux 2.4.2, running a "mount -o loop" on a file properly created with
> > "dd if=/dev/zero of=/path/to/my/file.img count=1024" seems to decide to
> > freeze up my shell (not my system). An strace showed the lockup happening at
> > the actual system "mount()" call, which never returns.
....
> I also experience this problem (using a floppy disk image created by
> dd if=/dev/fd0 of=floppy.img bs=1024, and then mount -o loop
> floppy.img /mnt/floppy ) with a different version
> of glibc (RedHat's 2.1.92-5 rpm) and binutils (binutils-2.10.0.18-1). Loop
> is compiled into the kernel.

Follow this thread -->
<http://marc.theaimsgroup.com/?l=linux-kernel&m=98289750805700&w=2>

Latest loop patch is available at
<ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.3-pre1/>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
