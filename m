Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbRGKBR5>; Tue, 10 Jul 2001 21:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbRGKBRr>; Tue, 10 Jul 2001 21:17:47 -0400
Received: from jalon.able.es ([212.97.163.2]:16861 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S267134AbRGKBR1>;
	Tue, 10 Jul 2001 21:17:27 -0400
Date: Wed, 11 Jul 2001 03:18:43 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Lista Mdk-Cooker <cooker@linux-mandrake.com>
Subject: Re: netlink, iproute and pump
Message-ID: <20010711031843.A6315@werewolf.able.es>
In-Reply-To: <20010711013446.A1076@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010711013446.A1076@werewolf.able.es>; from jamagallon@able.es on Wed, Jul 11, 2001 at 01:34:46 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010711 J . A . Magallon wrote:
>Hi, all...
>
>[I'm sending this both to lkml and distro support, beacause I am not sure who
>is to blame...]
>
>Well, fast synopsys: iniscripts use /sbin/ip from iproute2-2.2.4. That needs:
>CONFIG_NETLINK=y
>CONFIG_RTNETLINK=y
>to work. If I enable that, pump breaks (I have to try with another dhcp client...)
>So I can not enable correctly bot 'lo' and 'eth0' (with dhcp via cable modem) at
>the same time.
>
>????

After some tries, I reply to myself. pump is broken and dhcpcd works.
Looks like pump+packet_soket and netlink do not mix well...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.6-ac2 #1 SMP Sun Jul 8 23:57:11 CEST 2001 i686
