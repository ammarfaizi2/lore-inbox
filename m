Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313489AbSDQKga>; Wed, 17 Apr 2002 06:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313491AbSDQKga>; Wed, 17 Apr 2002 06:36:30 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:44952 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313489AbSDQKg3>; Wed, 17 Apr 2002 06:36:29 -0400
Date: Wed, 17 Apr 2002 12:20:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Artur Brodowski <bzd@astercity.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops report (or at least a try to make one)
In-Reply-To: <20020417122713.404e0cdd.bzd@astercity.net>
Message-ID: <Pine.LNX.4.44.0204171219110.30470-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Artur Brodowski wrote:

> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0128062>]    Tainted: P 
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 0100001d   ebx: c108f040   ecx: c0257afc   edx: c02579a0
> esi: 00000000   edi: c0257b24   ebp: 000000c0   esp: c7f8ff64
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 4, stackpage=c7f8f000)
> Stack: c108f040 c108f05c c0257b24 000000c0 c0131c76 c108f040 00000030 c0257b24         000000c0 c0130297 c108f040 00000030 c108f040 c0128893 c0126138 c108f040 
>               00000030 c108f040 c108f05c c01271b3 00000c54 c0257afc 0000148e 0008e000 
>               Call Trace: [<c0131c76>] [<c0130297>] [<c0128893>] [<c0126138>] [<c01271b3>] 
>                           [<c0127a9a>] [<c01054ef>] [<c01054f8>]
>                        Code: 0f 0b 89 d8 2b 05 ec 86 2a c0 69 c0 c5 4e ec c4 c1 f8 02 3b

Regarding the Tainted flag, are you loading nvidia's latest and greatest 
by any chance ?

	Zwane


