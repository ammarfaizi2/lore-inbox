Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274192AbRIXWIs>; Mon, 24 Sep 2001 18:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274193AbRIXWIh>; Mon, 24 Sep 2001 18:08:37 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:10368 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S274192AbRIXWI0>;
	Mon, 24 Sep 2001 18:08:26 -0400
Message-ID: <3BAFB034.1EDAB34F@randomlogic.com>
Date: Mon, 24 Sep 2001 15:14:12 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Reply-To: pallen@akamai.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Oops] Real G2 Beta7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone give me some insight on this?

Kernel 2.2.5-15smp, Red Hat, Network Engines P7000 Blade (Dual PII 500MHz)

Thanks,

PGA


"Allen, Paul" wrote:
> 
> >  -----Original Message-----
> > From:         Chaiyakul, Annie
> > Sent: Monday, September 24, 2001 2:14 PM
> > To:   Allen, Paul
> > Subject:      can you do some research on this error
> >
> > Sep 16 04:22:01 g2beta7 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
> > Sep 16 04:22:01 g2beta7 kernel: current->tss.cr3 = 186c6000, %cr3 = 186c6000
> > Sep 16 04:22:01 g2beta7 kernel: *pde = 00000000
> > Sep 16 04:22:01 g2beta7 kernel: Oops: 0000
> > Sep 16 04:22:01 g2beta7 kernel: CPU:    0
> > Sep 16 04:22:01 g2beta7 kernel: EIP: 0010:[do_generic_file_read+355/1540]
> > Sep 16 04:22:01 g2beta7 kernel: EFLAGS: 00010202
> > Sep 16 04:22:01 g2beta7 kernel: eax: 00000e44   ebx: 00000000   ecx: c0258644   edx: 00000010
> > Sep 16 04:22:01 g2beta7 kernel: esi: c5ebfba0   edi: 00000000   ebp: 00000000   esp: d90f7f3c
> > Sep 16 04:22:01 g2beta7 kernel: ds: 0018   es: 0018   ss: 0018
> > Sep 16 04:22:01 g2beta7 kernel: Process gawk (pid: 17749, process nr: 177, stackpage=d90f7000)
> > Sep 16 04:22:01 g2beta7 kernel: Stack: 00000000 d90f6000 c0258644 00000000 00000000 d9c95f00 c660ce40 00000000
> > Sep 16 04:22:01 g2beta7 kernel:        d90f6000 00000001 00000000 c5ebfba0 c011f66b d9c95f00 d9c95f14 d90f7f8c
> > Sep 16 04:22:01 g2beta7 kernel:        c011f5b8 d9c95f00 ffffffea 00000000 00000000 00001000 080b2900 00000000
> > Sep 16 04:22:01 g2beta7 kernel: Call Trace: [generic_file_read+99/124] [file_read_actor+0/80] [sys_read+194/232] [system_call+52/56]
> > Sep 16 04:22:01 g2beta7 kernel: Code: 39 72 08 75 f0 39 5a 0c 75 eb f0 ff 42 14 b8 02 00 00 00 f0
> > Sep 16 04:22:02 g2beta7 kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> > Sep 16 04:22:02 g2beta7 kernel: current->tss.cr3 = 182df000, %cr3 = 182df000
> > Sep 16 04:22:02 g2beta7 kernel: *pde = 00000000
> > Sep 16 04:22:02 g2beta7 kernel: Oops: 0000
> > Sep 16 04:22:02 g2beta7 kernel: CPU:    1
> > Sep 16 04:22:02 g2beta7 kernel: EIP:    0010:[try_to_read_ahead+123/292]
> > Sep 16 04:22:02 g2beta7 kernel: EFLAGS: 00010206
> > Sep 16 04:22:02 g2beta7 kernel: eax: 00000e44   ebx: 00000000   ecx: c0258644   edx: 00000014
> > Sep 16 04:22:02 g2beta7 kernel: esi: c4aea330   edi: ca866000   ebp: 00001000   esp: c8f37f18
> > Sep 16 04:22:02 g2beta7 kernel: ds: 0018   es: 0018   ss: 0018
> > Sep 16 04:22:02 g2beta7 kernel: Process gawk (pid: 17762, process nr: 177, stackpage=c8f37000)
> > Sep 16 04:22:02 g2beta7 kernel: Stack: c040e018 00001000 c0258644 c011f2ae d7c568c0 00001000 00000000 00001000
> > Sep 16 04:22:02 g2beta7 kernel:        080ad4c8 00000000 c8f36000 c0258640 00001000 00000000 00003000 0001f000
> > Sep 16 04:22:02 g2beta7 kernel:        00000000 00000001 00000001 00000000 c4aea330 c011f66b d7c568c0 d7c568d4
> >

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
