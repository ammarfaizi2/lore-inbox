Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283556AbRLDWPn>; Tue, 4 Dec 2001 17:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283558AbRLDWPd>; Tue, 4 Dec 2001 17:15:33 -0500
Received: from cc294686-a.union1.nj.home.com ([24.6.239.8]:49412 "EHLO
	gateway.patel.sh") by vger.kernel.org with ESMTP id <S283556AbRLDWPZ>;
	Tue, 4 Dec 2001 17:15:25 -0500
Message-Id: <200112042320.fB4NKmA00501@gateway.patel.sh>
Date: Tue, 4 Dec 2001 23:20:48 -0000
To: <linux-kernel@vger.kernel.org>
Subject: pcmcia error
From: "Dhaval Patel" <dhaval@patel.sh>
X-Mailer: TWIG 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First I would like to let you know that I dont have any pcmcia devices
installed in my box nor do I have any enabled in the kernel. Alright here is
the problem. I have the following hardware

dual 300 PII
AMI Megaraid
Netgear Fa310TX NIC
crappy ATI video card

and am trying to install kernel 2.4.16 on a fresh install of Slackware 8.0

I can configure the kernel with 'make menuconfig', compile the kernel with
'make bzImage' and compile the modules with 'make modules'. When I try to
install the modules with 'make modules_install' it does a bunch of stuff and
then stops at the following

cd /lib/modules/2.4.16; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.16; fi

I have been getting that with 2.4.5 and 2.4.14 as well as 2.4.16. 
I shearched the web and found someone with the same problem but found no
solution. Searching this mailing list didnt give me any solutions either.
Can anyone tell me what the problem is?
Thanks for your help.


 
