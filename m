Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135354AbRDRVeH>; Wed, 18 Apr 2001 17:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135357AbRDRVd5>; Wed, 18 Apr 2001 17:33:57 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:65008 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S135354AbRDRVdr>; Wed, 18 Apr 2001 17:33:47 -0400
Date: Wed, 18 Apr 2001 14:33:16 -0700
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Subject: kernel panic when using loop device on kernel 2.4.3
Message-ID: <20010418143316.A955@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have been getting kernel panics on kernel 2.4.3
when using the loop device on a rather regular basis.
I get a kernel panic but no oops message.  The kernel
panic message says Kernel panic: invalid blocksize passed
to set_blocksize.  I saw that someone else on the list
has had these problems as well but I have seen no response.
Has a fix for this bug been posted that I have not seen?
Is the fix in any current stable or AC kernel?  As far as
I know I am not using any strange options.  The only thing
I can think of would be that multiple people are using the
loopback device at the same time.  This is because the box
that is having the problems is a build server for a custom
software distro.  We use the loopback filesystem to create
the boot image.  The box is a 4way xeon with 1GB of ram.
Are there any known issues with loopback and SMP?  Or even
loopback and multiple mounts/usage?

ver_linux output attached.

Thanks,
Mike
-- 

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ver-linux

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux optimus.applianceware.com 2.4.3 #2 SMP Wed Apr 18 06:00:29 PDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         

--W/nzBZO5zC0uMSeA--
