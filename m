Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267168AbRGJXd6>; Tue, 10 Jul 2001 19:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267172AbRGJXds>; Tue, 10 Jul 2001 19:33:48 -0400
Received: from jalon.able.es ([212.97.163.2]:64730 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S267168AbRGJXdg>;
	Tue, 10 Jul 2001 19:33:36 -0400
Date: Wed, 11 Jul 2001 01:34:46 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Lista Mdk-Cooker <cooker@linux-mandrake.com>
Subject: netlink, iproute and pump
Message-ID: <20010711013446.A1076@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all...

[I'm sending this both to lkml and distro support, beacause I am not sure who
is to blame...]

Well, fast synopsys: iniscripts use /sbin/ip from iproute2-2.2.4. That needs:
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
to work. If I enable that, pump breaks (I have to try with another dhcp client...)
So I can not enable correctly bot 'lo' and 'eth0' (with dhcp via cable modem) at
the same time.

????

Thanks, let's hope this rings any bell...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.6-ac2 #1 SMP Sun Jul 8 23:57:11 CEST 2001 i686
