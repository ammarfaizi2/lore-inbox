Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTH3WGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 18:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTH3WGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 18:06:43 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:43249 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262191AbTH3WGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 18:06:39 -0400
Date: Sat, 30 Aug 2003 22:58:28 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre2
Message-Id: <20030830225828.3789963e.dave.bentham@ntlworld.com>
In-Reply-To: <Pine.LNX.4.55L.0308301550100.31588@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308301550100.31588@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__30_Aug_2003_22:58:28_+0100_08216d48"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__30_Aug_2003_22:58:28_+0100_08216d48
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I lied!

I've managed to get the 2.4.22 oops tonight. See attached.

Dave



On Sat, 30 Aug 2003 15:52:18 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> The 2.4.22 oops would be more useful.
> 


-- 
A computer without Microsoft is like chocolate cake without mustard.


--Multipart_Sat__30_Aug_2003_22:58:28_+0100_08216d48
Content-Type: text/plain;
 name="Telekon-2.4.22-oops.txt"
Content-Disposition: attachment;
 filename="Telekon-2.4.22-oops.txt"
Content-Transfer-Encoding: 7bit

ksymoops 2.4.5 on i686 2.4.22.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /var/log/ksyms.1 (specified)
     -L (specified)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000                                  
*pde = 00000000
Oops: 0000        
CPU:    0
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202       
eax: c02e7954   ebx: c02e7b40   ecx: 000000
  [<c01d0939>] [<c01ca1e5>] [<c01c9b30>] [<c01d7805>] [<c01d8a7b>] [<c01d6045>]
  [<c01df81e>] [<c01df892>] [<c01404ba>] [<c01d67c8>] [<c01def5a>] [<c01dedb1>]
  [<c013bb1f>] [<c01406d1>] [<c014075f>] [<c017fc06>] [<c013f1dc>] [<c013f5e3>]
  [<c015197d>] [<c0151c75>] [<c0151ada>] [<c0152094>] [<c01092df>]             
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c02e7954 <ide_hwifs+454/2b48>
>>ebx; c02e7b40 <ide_hwifs+640/2b48>

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010203
eax: c02e7954   ebx: c02e7b40   ecx: 00000000   edx: 00000170
esi: cdd74480   edi: cfea8a00   ebp: c02ade94   esp: c02ade6c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02ad000)
Stack: c01d4c64 c02e7b40 cdd74480 0000000c 00000000 000001f4 cfea8a00 c02e7b40
       00000040 00000000 c02adec8 c01bca72 c02e7b40 cdd74480 00000000 00000088
       000001f4 c02adeec 00000000 00000018 c02e7b40 cff1b280 cc030e00 c02adeec
Call Trace:    [<c01d4c64>] [<c01bca72>] [<c01bcbf5>] [<c01bcf06>] [<c019e861>]
  [<c01bce20>] [<c0122f0b>] [<c0122666>] [<c011f412>] [<c011f306>] [<c011f136>]
  [<c010a9b0>] [<c0107250>] [<c010d038>] [<c0107250>] [<c0107273>] [<c0107302>]
  [<c0105000>]
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c02e7954 <ide_hwifs+454/2b48>
>>ebx; c02e7b40 <ide_hwifs+640/2b48>
>>esi; cdd74480 <_end+da87528/10517108>
>>edi; cfea8a00 <_end+fbbbaa8/10517108>
>>ebp; c02ade94 <init_task_union+1e94/2000>
>>esp; c02ade6c <init_task_union+1e6c/2000>

Trace; c01d4c64 <idescsi_transfer_pc+124/130>
Trace; c01bca72 <start_request+192/210>
Trace; c01bcbf5 <ide_do_request+b5/1a0>
Trace; c01bcf06 <ide_timer_expiry+e6/1c0>
Trace; c019e861 <rs_timer+d1/140>
Trace; c01bce20 <ide_timer_expiry+0/1c0>
Trace; c0122f0b <run_timer_list+10b/170>
Trace; c0122666 <update_wall_time+16/40>
Trace; c011f412 <bh_action+22/50>
Trace; c011f306 <tasklet_hi_action+46/70>
Trace; c011f136 <do_softirq+a6/b0>
Trace; c010a9b0 <do_IRQ+b0/c0>
Trace; c0107250 <default_idle+0/40>
Trace; c010d038 <call_do_IRQ+5/d>
Trace; c0107250 <default_idle+0/40>
Trace; c0107273 <default_idle+23/40>
Trace; c0107302 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

 <0>Kernel panic: Aiee, killing interrupt handler!

--Multipart_Sat__30_Aug_2003_22:58:28_+0100_08216d48--
