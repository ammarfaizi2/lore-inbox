Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281181AbRKOX7E>; Thu, 15 Nov 2001 18:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281183AbRKOX6p>; Thu, 15 Nov 2001 18:58:45 -0500
Received: from mons.uio.no ([129.240.130.14]:48862 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281181AbRKOX6n>;
	Thu, 15 Nov 2001 18:58:43 -0500
To: Birger Lammering <lammering@planet-interkom.de>
Cc: linux-kernel@vger.kernel.org, birger.lammering@science-computing.de
Subject: Re: nfs problem: hp-server --- linux 2.4.13 client, ooops
In-Reply-To: <20011115222920.A9929@ludwig2.science-computing.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Nov 2001 00:58:38 +0100
In-Reply-To: <20011115222920.A9929@ludwig2.science-computing.de>
Message-ID: <shssnbf37td.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Birger Lammering <lammering@planet-interkom.de> writes:

     > Without the nfs patch I had a lot of trouble with Irix servers
     > - now Irix, NetApp, Aix, Linux... nfs- servers are fine, but
     > connecting to a HP server leads to statements like this in the
     > syslog: NFS: short packet in readdir reply!

<snip>
     > Unable to handle kernel paging request at virtual address
     > fe01e000
     >  printing eip:
     > f898eaed *pde = 00004063 *pte = 00000000 Oops: 0000 CPU: 1 EIP:
     > 0010:[<f898eaed>] Not tainted EFLAGS: 00010296 eax: 01000000
     > ebx: fe01dff8 ecx: fe01e000 edx: 00000019 esi: fe01e000 edi:
     > 0000006c ebp: f537405c esp: f4e83c60 ds: 0018 es: 0018 ss: 0018
     > Process ls (pid: 11091, stackpage=f4e83000) Stack: f4e83cec
     > f518c200 f898ea4c f8956e07 f537405c f6a15240 f4e83d94 f4e83d40
     >        f4e83d54 f4e83cac 00000002 f895a18c f4e83cec f4e83cec
     >        fffffff5
     > f4e83cec
     >        f518c200 f4e82000 f4e82000 00000000 f4e82000 f4e83d58
     >        f4e83d58
     > f895a498 Call Trace: [<f898ea4c>] [<f8956e07>] [<f895a18c>]
     > [<f895a498>] [<f895646e>]
     >    [<f8997520>] [<f89594e0>] [<f898e09e>] [<f8997520>]
     >    [<f898b89a>]
     > [<c01299e8>]
     >    [<f898bc2b>] [<f898b7c0>] [<f898eb1c>] [<c0142bb4>]
     >    [<c0142f90>]
     > [<c01430f3>]
 
That particular Oops should already be fixed in 2.4.14.

Cheers,
   Trond
