Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130421AbRBLFQM>; Mon, 12 Feb 2001 00:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130387AbRBLFQD>; Mon, 12 Feb 2001 00:16:03 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:34230 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129977AbRBLFPx>; Mon, 12 Feb 2001 00:15:53 -0500
From: "C. D. Thompson-Walsh" <cdthompsonwalsh@home.com>
Reply-To: cdthompsonwalsh@home.com
Date: Mon, 12 Feb 2001 01:17:25 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Organization: -
To: linux-kernel@vger.kernel.org
Subject: Problem: Floppy drive[?] hang
MIME-Version: 1.0
Message-Id: <01021201172500.00922@ariel>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This sortof follows the format of the report form in REPORTING-BUGS]
1. I've found a consistent set of circumstances which will hang 2.4.x kernels 
on my system.

2. If the system is put under load to the point where it swaps heavily 
(swapping appears to be pre-requisite, based on a little messing about), and 
then given commands to use the floppy drive (mount, ls -- anything which 
necessitates reading/writing to the floppy), it will hang with no message (it 
does not OOPS, or at least it can not to the root console) I've done this 
several times, with different disks and kernels, with and without X.

3. Hang, floppy, vm, swap

4. 2.4.0, 2.4.1, compiled on egcs gcc 2.91.66

7. My system is a K6 (well behaved to date, w/o bug, afaik) on an Acer mb; 
ALi M5229 IDE, ALi M15nn bridges... Unfortunately, I can't give the precise 
mb at the moment... 
However, if necessary, I can find out (system was bought as an IBM desktop, 
therefore the documentation is totally useless and in order to find anything 
out about hardware I either have to cunningly read the boot logs/ISA probing 
& interpret or read the green-on-green writing on the mb)... I can't think of 
any other relevant details, but I would be happy to respond to additional 
queries for information.

7.2  Relevant /proc/cpuinfo :
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx  

[the rest of the bug reporting form seems excessive...]

I hope this will be helpful... I'll be reading the mailing list, so if you 
would like to ask for info, blame my hardware, or insult my style (it's late 
in my timezone!), feel free.

Best wishes,
C. D. Thompson-Walsh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
