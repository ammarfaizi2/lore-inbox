Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRHRWE1>; Sat, 18 Aug 2001 18:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268792AbRHRWES>; Sat, 18 Aug 2001 18:04:18 -0400
Received: from ns.suse.de ([213.95.15.193]:15625 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268570AbRHRWEH>;
	Sat, 18 Aug 2001 18:04:07 -0400
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Aliases
In-Reply-To: <00df01c127a8$c354ad20$bb1cfa18@JimWS.suse.lists.linux.kernel> <Pine.LNX.4.33.0108180245070.27721-100000@kobayashi.soze.net.suse.lists.linux.kernel> <20010818143232.A11687@bacchus.dhis.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Aug 2001 00:04:18 +0200
In-Reply-To: Ralf Baechle's message of "18 Aug 2001 14:44:48 +0200"
Message-ID: <oupy9ohqb31.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@uni-koblenz.de> writes:
> 
> For various reasons interfaces aliases are deprecated.  The recommended
> way of doing things these days is just adding more addresses to an
> interface with the ip(8) program from the iproute package.  It works like:
> 
>   ip addr add 192.168.2.0/24 broadcast 192.168.2.255 scope host dev eth0

Newer ifconfig also supports "add" for IPv4 (older supported it only for 
v6)

The problem of the original poster is also likely to have an too old ifconfig;
older ones had some O(n^2) algorithms with hurt with many interfaces.

-Andi
