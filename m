Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131784AbRAUADr>; Sat, 20 Jan 2001 19:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131831AbRAUAD2>; Sat, 20 Jan 2001 19:03:28 -0500
Received: from [203.36.158.121] ([203.36.158.121]:56196 "EHLO kabuki.eyep.net")
	by vger.kernel.org with ESMTP id <S131784AbRAUADP>;
	Sat, 20 Jan 2001 19:03:15 -0500
Subject: Re: 2.4 and ipmasq modules
From: Daniel Stone <daniel@kabuki.eyep.net>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010120153403.A17269@vitelus.com>
In-Reply-To: <20010120144616.A16843@vitelus.com>  
	<E14K7UY-0004hB-00@kabuki.eyep.net>  <20010120153403.A17269@vitelus.com>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 21 Jan 2001 11:08:00 +1100
Mime-Version: 1.0
Message-Id: <E14K83B-0004lQ-00@kabuki.eyep.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jan 2001 15:34:03 -0800, Aaron Lehmann wrote:
> On Sun, Jan 21, 2001 at 10:32:15AM +1100, Daniel Stone wrote:
> > FTP is under Connection Tracking support, FTP connection tracking. Does
> > the same stuff as ip_masq_ftp. IRC is located in patch-o-matic -
> > download iptables 1.2 and do a make patch-o-matic, there is also RPC and
> > eggdrop support in there. I'm half in the middle of porting ip_masq_icq,
> > but it's one hideously ugly kludge after another. Such is life.
> 
> That option seems to conflict with "ipfwadm (2.0-style) support".
> Preferably, I'd like to stay with friendly old ipfwadm rather than
> switching firewalling tools _again_.


Your choice, but if you choose not to switch, you lose the power of:
* stateful inspection
* modules
* a sane command line
* a metric shitload of extensions

"I'd rather stay with my friendly old pushbike than my car!"
So don't complain when you can't use cruise control.

d

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
