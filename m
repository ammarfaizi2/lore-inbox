Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310924AbSCMSI3>; Wed, 13 Mar 2002 13:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310950AbSCMSIU>; Wed, 13 Mar 2002 13:08:20 -0500
Received: from pegasus.wanadoo.be ([195.74.212.10]:65189 "EHLO
	pegasus.wanadoo.be") by vger.kernel.org with ESMTP
	id <S310924AbSCMSIG>; Wed, 13 Mar 2002 13:08:06 -0500
Date: Wed, 13 Mar 2002 19:07:51 +0100 (CET)
From: Francois Baligant <francois@ops.be.wanadoo.com>
X-X-Sender: francois@speedy.noc.euronet.be
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.19-pre3 locks solid at boot for Intel machine check
Message-ID: <Pine.LNX.4.44.0203131906510.23034-100000@speedy.noc.euronet.be>
X-NCC-RegID: be.euronet
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sorry for the dupe if any, mail not reliable here today)

        I just tried plain 2.4.19-pre3 and it locks just after: 

CPU: L1 I cache: 16K, L1 D cache: 16K 
CPU: L2 cache: 512K 
Intel machine check architecture supported. 

where it display with 2.4.17-0.8 (rawhide): 

CPU: L1 I cache: 16K, L1 D cache: 16K 
CPU: L2 cache: 512K 
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 000000000 
CPU serial number disabled 
Intel machine check architecture supported. 
Intel machine check reporting enabled on CPU#0. 

cat /proc/cpuinfo 

processor       : 0 
vendor_id       : GenuineIntel 
cpu family      : 6 
model           : 7 
model name      : Pentium III (Katmai) 
stepping        : 2 
cpu MHz         : 501.158 
cache size      : 512 KB 
fdiv_bug        : no 
hlt_bug         : no 
f00f_bug        : no 
coma_bug        : no 
fpu             : yes 
fpu_exception   : yes 
cpuid level     : 2 
wp              : yes 
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse 
bogomips        : 999.42 

        Is this a know problem ? 

Francois Baligant                Lozenberg 22 - B-1932 Zaventem 
Wanadoo Belgium NV/SA    francois@be.wanadoo.com 
Network Operation Center    tel: +32 2 717 17 17 
FB1-6BONE FB3122-RIPE  fax: +32 2 717 17 77 




