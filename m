Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277712AbRJIEG3>; Tue, 9 Oct 2001 00:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277709AbRJIEGT>; Tue, 9 Oct 2001 00:06:19 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.11.31.247]:9344 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S277712AbRJIEGK>; Tue, 9 Oct 2001 00:06:10 -0400
Message-ID: <3BC277C9.E28C4457@home.com>
Date: Mon, 08 Oct 2001 23:06:33 -0500
From: Jordan Breeding <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-ac10-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Truncated dmesg at boot up
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing a weird problem, and have been for some time, where the
messages output to the console during boot up and truncated.  The first
few lines, always a different amount of lines, are always missing and
can not be seen by doing `dmesg` or `cat /var/log/dmesg`.  I have been
using the -ac branch exclusively and am currently using -ac with the
most up-to-date CVS ext3 -ac merge and Robert Love's most current
preempt patches.  Currently I am running 2.4.10-ac10 with the
2.4.7-ac7-ext3-0.9.12 branch of ext3 CVS to get me up to date with ext3
and also running the 2.4.10-ac10 set of preempt patches.  Here is the
begining of what is contained in both the output of `dmesg` and `cat
/var/log/dmesg`:

== BEGIN OUTPUT ==
0 (reserved)
127MB HIGHMEM available.
found SMP MP-table at 000f5620
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: ro root=/dev/hda5 rootflags=data=journal
video=aty128fb:1280x1024 hdb=scsi hdc=scsi hdd=scsi
ide_setup: hdb=scsi
ide_setup: hdc=scsi
ide_setup: hdd=scsi
== END OUTPUT ==

There used to be more information at the top and I do not know why
recently I have not been able to see this information anymore.  Thanks
to anyone who can help.

Jordan Breeding
