Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRA3KRU>; Tue, 30 Jan 2001 05:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129367AbRA3KRK>; Tue, 30 Jan 2001 05:17:10 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:49674 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S129311AbRA3KQ7>; Tue, 30 Jan 2001 05:16:59 -0500
Date: Tue, 30 Jan 2001 02:16:58 -0800
From: David Rees <dbr@spoke.nols.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre10 -> 2.4.1 klogd at 100% CPU ; 2.4.0 OK
Message-ID: <20010130021657.A15324@spoke.nols.com>
Mail-Followup-To: David Rees <dbr@spoke.nols.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying different 2.4.1-pre kernels trying to find one that 
doesn't end up with klogd pegging the CPU.  2.4.0 is OK, but 
2.4.1-pre10 to 2.4.1 all leave klogd sitting at 100% CPU.

The machine in question is a Gateway E-3200, a basic PIII-500 running RH 
7.0 with all the latest updates as well as the recommended updates 
documented in the Changes file.  The kernel is compiled with kgcc 
(egcs-1.1.2).

Below is the output from various files to hopefully give some hits as to 
what may be the problem:

> sh scripts/ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux shooter.ebetinc.com 2.4.0-c1 #1 Tue Jan 30 02:08:19 PST 2001 i686 
unknown
Kernel modules         2.4.1
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.33
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         


.config is at http://spoke.nols.com/~drees/config.txt
cpuinfo is at http://spoke.nols.com/~drees/cpuinfo.txt
dmesg is at   http://spoke.nols.com/~drees/dmesg.txt

Thanks,
Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
