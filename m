Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131439AbRATX2A>; Sat, 20 Jan 2001 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbRATX1t>; Sat, 20 Jan 2001 18:27:49 -0500
Received: from [203.36.158.121] ([203.36.158.121]:49284 "EHLO kabuki.eyep.net")
	by vger.kernel.org with ESMTP id <S131439AbRATX1h>;
	Sat, 20 Jan 2001 18:27:37 -0500
Subject: Re: 2.4 and ipmasq modules
From: Daniel Stone <daniel@kabuki.eyep.net>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010120144616.A16843@vitelus.com>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 21 Jan 2001 10:32:15 +1100
Mime-Version: 1.0
Message-Id: <E14K7UY-0004hB-00@kabuki.eyep.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FTP is under Connection Tracking support, FTP connection tracking. Does
the same stuff as ip_masq_ftp. IRC is located in patch-o-matic -
download iptables 1.2 and do a make patch-o-matic, there is also RPC and
eggdrop support in there. I'm half in the middle of porting ip_masq_icq,
but it's one hideously ugly kludge after another. Such is life.

d


On 20 Jan 2001 14:46:16 -0800, Aaron Lehmann wrote:
> It was great to see that 2.4.0 reintroduced ipfwadm support! I had no
> need for ipchains and ended up using the wrapper around it that
> emulated ipfwadm. However, 2.[02].x used to have "special IP
> masquerading modules" such as ip_masq_ftp.o, ip_masq_quake.o, etc. I
> can't find these in 2.4.0. Where have they gone? Without important
> modules such as ip_masq_ftp.o I cannot use non-passive ftp from behind
> the masquerading firewall.
> 
> Thanks,
> Aaron Lehmann
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/



-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
