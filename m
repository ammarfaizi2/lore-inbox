Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284191AbRLFUVL>; Thu, 6 Dec 2001 15:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284182AbRLFUSE>; Thu, 6 Dec 2001 15:18:04 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:32376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284189AbRLFUQz>;
	Thu, 6 Dec 2001 15:16:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian Roth <xsebbi@gmx.de>
Reply-To: xsebbi@gmx.de
Message-Id: <200112062048.45316@xsebbi.de>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: spurious interrupt with 2.4.10 and higher ?
Date: Thu, 6 Dec 2001 20:58:04 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all!

For a long time, I receive at boot time (and in /var/log/warn) the following 
message from the kernel:

Spurious 8259A interrupt: IRQ7

Could you tell me please, what is it? My System works fine but I hate this 
message. :-)

Do you need more information?

/proc/cpuinfo says :

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 701.619
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1399.19

/proc/devices says :

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 13 input
 14 sound
 29 fb
108 ppp
109 lvm
128 ptm
136 pts
162 raw
180 usb

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  7 loop
  9 md
 22 ide1
 58 lvm

/proc/dma :

 1: SoundBlaster8
 2: floppy
 4: cascade
 5: SoundBlaster16

/proc/interrupt :

           CPU0       
  0:    2825799          XT-PIC  timer
  1:      14178          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:    1206018          XT-PIC  soundblaster
  6:         58          XT-PIC  floppy
  8:          2          XT-PIC  rtc
 11:        238          XT-PIC  eth0, usb-uhci, usb-uhci
 12:    1177362          XT-PIC  PS/2 Mouse
 14:     148838          XT-PIC  ide0
 15:     284100          XT-PIC  ide1
NMI:          0 
LOC:    2825758 
ERR:       1550
MIS:          0

information enough?
my actual kernel is 2.4.10 with 2.4.16 I've got the same message..

Thank you and
Bye,
Sebastian

