Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130189AbRBFGl7>; Tue, 6 Feb 2001 01:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbRBFGlt>; Tue, 6 Feb 2001 01:41:49 -0500
Received: from cast-ext.ab.videon.ca ([206.75.216.34]:64753 "HELO
	cast-ext.ab.videon.ca") by vger.kernel.org with SMTP
	id <S130189AbRBFGle>; Tue, 6 Feb 2001 01:41:34 -0500
Date: Mon, 5 Feb 2001 23:54:46 -0700
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.1 thinks my Cyrix 6x86 P166 is a 486-class machine
Message-ID: <20010205235446.A1286@lovelife.olvc.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Anthony Fok <foka@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux 2.4.1 (and 2.4.2-pre1) thinks my Cyrix 6x86 P166+ is a i486-class
machine. (It is a i586-class CPU.)  2.4.0 didn't recognize the
model name; 2.4.1 fixed that, but I guess the cpu family part may need
fixing too.

$ uname -a
Linux lovelife 2.4.2-pre1 #2 Mon Feb 5 21:26:22 MST 2001 i486 unknown

$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 4
model           : 2
model name      : 6x86 2x Core/Bus Clock
stepping        : 6
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : no
cpuid level     : -1
wp              : yes
flags           : cyrix_arr
bogomips        : 133.12

I'm running Debian 2.2r2 plus some updated packages on this machine.

Thanks for your help.

Anthony

-- 
Anthony Fok Tung-Ling                Civil and Environmental Engineering
foka@ualberta.ca, foka@debian.org    University of Alberta, Canada
   Debian GNU/Linux Chinese Project -- http://www.debian.org/intl/zh/
Come visit Our Lady of Victory Camp -- http://www.olvc.ab.ca/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
