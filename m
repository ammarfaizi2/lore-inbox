Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316943AbSEWQYB>; Thu, 23 May 2002 12:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316944AbSEWQYA>; Thu, 23 May 2002 12:24:00 -0400
Received: from web14204.mail.yahoo.com ([216.136.172.146]:35606 "HELO
	web14204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316943AbSEWQX7>; Thu, 23 May 2002 12:23:59 -0400
Message-ID: <20020523162359.62535.qmail@web14204.mail.yahoo.com>
Date: Thu, 23 May 2002 09:23:59 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: 2.5.17 Module woes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is just too wierd....

In logs the following....
request_module[scsi_hostadaptor]: Root fs not mounted
last message repeated 3 times
modprobe: modprobe: Can't locate module eth1
insmod: /lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o: insmod
iptable_nat failed

Ok, so why are these strange.  First of all, there is nothing remotely scsi in
this box.  Also, eth1 driver is compiled into the kernel.  Masq was working
fine, so the last message isn't important, except that it was trying to load a
module from 2.4.18 on a 2.5 box?

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
