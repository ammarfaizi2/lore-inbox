Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280062AbRKITiT>; Fri, 9 Nov 2001 14:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280081AbRKITiJ>; Fri, 9 Nov 2001 14:38:09 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:46274 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S280062AbRKITiB> convert rfc822-to-8bit; Fri, 9 Nov 2001 14:38:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roby <robylit@inwind.it>
Reply-To: robylit@inwind.it
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: The module loop.o has an unresolved dependency: deactivate_page()
Date: Fri, 9 Nov 2001 19:34:06 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011109193802Z280062-17408+12724@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.14

[1.] The module loop.o has an unresolved dependency: deactivate_page()
[2.] If I compile the module loop.o as a module it compiles fine,but then it 
has un unresolved dependency: deactivate_page(). This function once was in 
the source file mm/swap.c, but in the kernel 2.4.14 it disappeared. I know 
the function existed in the kernel 2.4.10.
[3.] module, deactivate_page(), loop.o, swap.c
[4.] Kernel 2.4.14, downloaded from www.kernel.org (vanilla, no ac patch)
[7.2] processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1109.919
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2215.11

[8.] The function deactivate_page() is not defined elsewhere. What have I to 
do for having the loop block device?
[9.] ]$ cat version
Linux version 2.4.14 (root@darkstar) (gcc version egcs-2.91.66 19990314/Linux 
(egcs-1.1.2 release)) #6 Wed Nov 7 22:22:30 CET 2001

-- 
Roby

email
robylit@inwind.it
robylit@tiscali.it

WEB Page
http://web.tiscali.it/robylit
