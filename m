Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293599AbSCFP6N>; Wed, 6 Mar 2002 10:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293625AbSCFP6D>; Wed, 6 Mar 2002 10:58:03 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:57836 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293599AbSCFP5z>; Wed, 6 Mar 2002 10:57:55 -0500
Date: Wed, 6 Mar 2002 17:43:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Vincent Bernat <bernat@free.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: xmms segfaulting on 2.4.18 and 2.4.19-pre2-ac2 + oops
In-Reply-To: <m3pu2hn1z2.fsf@neo.loria>
Message-ID: <Pine.LNX.4.44.0203061739480.19993-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Vincent Bernat wrote:

> Unable to handle kernel paging request at virtual address d8d5c000
> d8d56730
> *pde = 17c45067
> Oops: 0000
> CPU:    0
> EIP:    0010:[3c59x:__insmod_3c59x_S.bss_L40+828820/101914768]    Not tainted
> EFLAGS: 00210202
> eax: 00000001   ebx: 00000003   ecx: ffff389f   edx: fffff888
> esi: fffff888   edi: d8d59fa6   ebp: d8d5bffe   esp: c445fe90
> ds: 0018   es: 0018   ss: 0018
> Process xmms (pid: 2679, stackpage=c445f000)
> Stack: d8d56840 d8d56730 cae1c710 cae1c6f0 00000000 00000004 00000004 00000001 
>        f871f871 00000c29 000003ec 00000400 cae1c680 c551b3c0 d8d56a8a cae1c680 
>        c7a8b500 c7a8b480 00000400 000003ec cae1c680 00000400 cae1c680 00000400 
> Call Trace: [3c59x:__insmod_3c59x_S.bss_L40+829092/101914496] [3c59x:__insmod_3c59x_S.bss_L40+828820/101914768] [3c59x:__insmod_3c59x_S.bss_L40+829678/101913910] [3c59x:__insmod_3c59x_S.bss_L40+817016/101926572] [3c59x:__insmod_3c59x_S.bss_L40+802037/101941551] 
> Code: 8b 75 00 e9 87 00 00 00 8b 75 00 81 f6 00 80 00 00 eb 7c 8b 
> Using defaults from ksymoops -t elf32-i386 -a i386

I don't think its the 3com's driver fault, please run the decoded oops 
right after xmms crashes and make sure the map file specified is the 
correct one. Check out ksymoops(8) for perhaps more help.

	Zwane


