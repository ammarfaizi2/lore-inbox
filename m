Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132889AbRDEOR0>; Thu, 5 Apr 2001 10:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132901AbRDEORS>; Thu, 5 Apr 2001 10:17:18 -0400
Received: from [212.97.52.90] ([212.97.52.90]:35826 "HELO odino.preciso.net")
	by vger.kernel.org with SMTP id <S132889AbRDEORM>;
	Thu, 5 Apr 2001 10:17:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: gianpaolo racca <gianpaolo@preciso.net>
Reply-To: gianpaolo@preciso.net
Organization: gianpaolo racca
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.3 on HP netserver LH4
Date: Thu, 5 Apr 2001 16:13:57 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040516135706.02185@loki.preciso.mgt>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning and excuse for disturbing you

I have to mantain an HP netserver lh4 in Statale University of Milan (Italy).
Due to some routing issues I would like to switch to kernel 2.4.
I'm not a kernel hacjer but I have already installed it on two nobrand boxes 
(one with redhat 6.1 and the other with mandrake 7.2).
With netserver the problem I think is the allocation of PCI resources. 
Maybe is the 450NX chipset the cause of the problem.
After having ercompiled and installed yhe new kernel during the boot I recive 
some messages like:
PCI: cannot allocate resource region 0 for 0:1.4
PCI: cannot allocate resource region 1 for 0:1.4
PCI: cannot allocate resource region 2 for 0:1.4
PCI: cannot allocate resource region 0 for 0:1.6
PCI: cannot allocate resource region 1 for 0:1.6
PCI: cannot allocate resource region 2 for 0:1.6
PCI: cannot allocate resource region 0 for 0:1.7
PCI: cannot allocate resource region 1 for 0:1.7
PCI: cannot allocate resource region 2 for 0:1.7

device 4 is an ethernet adapter while device 6 and 7 are (according to lspci 
of kernel 2.2.18) the two scsi channels.
there are 2 other network adapters on 0:2.x (which I think is the other pci 
bus) but they are not mentioned during 2.4.3 boot.

To make things short and quick after these messages the controller give me a 
message of CACHE FAILED and doesn't recognize its devices, so that the kernel 
doesn't find the root partition.

What do I miss? Do you have notices of a Netserver lh4 running a 2.4.x kernel?
Any suggestion is really welcome.

I can post my current kernel config, any output I can obtain from a 2.2.18 
kernel (which is still running at the moment).

Thanks in advance,

         gianpaolo racca
         gianpaolo@preciso.net
