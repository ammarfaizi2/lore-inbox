Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRIBSAx>; Sun, 2 Sep 2001 14:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRIBSAn>; Sun, 2 Sep 2001 14:00:43 -0400
Received: from f60.law3.hotmail.com ([209.185.241.60]:18446 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267534AbRIBSAf>;
	Sun, 2 Sep 2001 14:00:35 -0400
X-Originating-IP: [65.25.189.2]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 Oops
Date: Sun, 02 Sep 2001 18:00:48 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F60wACkWHZqYW8BYXif0000441b@hotmail.com>
X-OriginalArrivalTime: 02 Sep 2001 18:00:49.0210 (UTC) FILETIME=[328CE9A0:01C133D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had a 2.2.19smp (stock 2.2.19 with SMP enabled) box oops after 132 
days uptime. The machine is i386 SMP (dual Pentium), with an AM53c794 SCSI 
controller (using the tmscsim.o module).

The crash happened around 4am with no one logged into the machine. As nearly 
as a I can tell, nothing special was going on on the machine either (it is a 
firewall/routing box). I had to hand copy the oops and run it through 
ksymoops. I rechecked everything and think I got the addresses right but...

Any ideas what might be going on?

>>EIP; c0113648 <__wake_up+38/80>   <=====
Trace; c012b921 <end_buffer_io_async+dd/150>
Trace; c01b11b8 <end_scsi_request+84/138>
Trace; c01b1881 <rw_intr+2f5/644>
Trace; c01b031c <scsi_old_done+570/57c>
Trace; c01ba9b8 <dc390_SRBdone+49c/4b4>
Trace; c01ba1c8 <dc390_Disconnect+12c/138>
Trace; c01b91f2 <do_DC390_Interrupt+122/1e0>
Trace; c010b12a <handle_IRQ_event+5a/8c>
Trace; c01102de <do_level_ioapic_IRQ+62/a0>
Trace; c010b2ab <do_IRQ+4b/5c>
Trace; c010a2a0 <common_interrupt+18/20>
Trace; c0107a55 <cpu_idle+3d/50>
Trace; c010a275 <do_8259A_IRQ+c5/d8>
Trace; c011b689 <do_bottom_half+81/a0>
Trace; c010b2b2 <do_IRQ+52/5c>

- John


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

