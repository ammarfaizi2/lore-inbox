Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270592AbTGURsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270651AbTGURsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:48:09 -0400
Received: from 66-133-183-62.br1.fod.ia.frontiernet.net ([66.133.183.62]:43153
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id S270671AbTGURqT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:46:19 -0400
From: Russell Miller <rmiller@duskglow.com>
Reply-To: rmiller@duskglow.com
Organization: If you only saw my house...
To: linux-kernel@vger.kernel.org
Subject: oops, sorry (2.6.0-test1 reboots)
Date: Mon, 21 Jul 2003 13:01:11 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307211301.15630.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it occurs to me that I didn't provide sufficient information.  To recount, my 
kernel reboots on load.  Here's the .config

http://www.duskglow.com/2.6-config

here is the output of lspci:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI 
Audio Accelerator (rev 02)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI 
Accelerator+3D (rev 31)

here is cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 902.055
cache size      : 256 KB
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
bogomips        : 1802.24

Hope this helps
please cc me.

--Russell

-- 
Randomly generated fortune cookie:
In good speaking, should not the mind of the speaker know the truth of the 
matter about which he is to speak? -- Plato

Russell Miller - rmiller@duskglow.com - Somewhere near Sioux City, IA.
Youth cannot know age, but age is guilty if it forgets youth
    - Professor Dumbledore

