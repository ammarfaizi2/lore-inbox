Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313670AbSDPNV0>; Tue, 16 Apr 2002 09:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313671AbSDPNVZ>; Tue, 16 Apr 2002 09:21:25 -0400
Received: from polywog.navpoint.com ([207.106.42.251]:1152 "EHLO
	polywog.navpoint.com") by vger.kernel.org with ESMTP
	id <S313670AbSDPNVY>; Tue, 16 Apr 2002 09:21:24 -0400
Date: Tue, 16 Apr 2002 09:28:11 -0400 (EDT)
From: E M Recio <polywog@navpoint.com>
X-X-Sender: <erecio@polywog.navpoint.com>
To: <linux-kernel@vger.kernel.org>
Subject: AMD Athlon + VIA Crashing On Disk I/O
Message-ID: <Pine.LNX.4.33.0204160921060.472-100000@polywog.navpoint.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

I have an AMD Athlon 1.2 with a VIA 8259A Chipset (see bottom). If I
compile the kernel with the Athlon option it crashes all the time. In
fact, I can't even get Redhat 7.2 installed without a core dump when it
tries to mount the filesystem. With the later kernels, it doesn't core
dump, but just freezes.

IE: If I have ide-scsi module loaded, and I try to access the floppy
drive, it locks up the machine (regardless of whether cputype is Athlon
or K6.)

IE: Updatedb locks up the machine.

I get (when FSCK):

spurious 8259A IRQ7

Does anyone know if there's a bug fix for this chipset? My board is
made from FIC (crappy, instructions don't even matchup). I used to be
able to fix it by changing the CPU type to K6 but that doesn't work now
with the later kernels (2.4.15 and up.)

5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-c00f : VIA Technologies, Inc. Bus Master IDE

-- 

Best Regards,
E. M. Recio

****************************************************
* Email: < polywog@navpoint.com > ICQ: < 458043 >  *
* Homepage: < http://polywog.navpoint.com >        *
****************************************************

