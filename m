Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131039AbRBXBBu>; Fri, 23 Feb 2001 20:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131056AbRBXBBj>; Fri, 23 Feb 2001 20:01:39 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:8722 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S131039AbRBXBBZ>;
	Fri, 23 Feb 2001 20:01:25 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Sat, 24 Feb 2001 01:04:55 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OPPS] 2.2.18 + Scheduling in interrupt
Message-ID: <Pine.LNX.4.21.0102240059240.1317-101000@cyrix.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811583-878053310-982976695=:1317"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811583-878053310-982976695=:1317
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi

this is the first opps i got from several
i have attached the rest in a gzip file

these were the messages i got

Aiee, killing interrupt handler
alloc_skb called nonatomically from interrupt c016468f
eth0: Tx request while isr active.
Scheduling in interrupt

first opps

Unable to handle kernel NULL pointer dereference at virtual address
00000000
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0110b36>]
EFLAGS: 00010286
eax: 00000018   ebx: c1ef2000   ecx: 000002fd   edx: c799c000
esi: 00000000   edi: c2b9e220   ebp: c1ef3bf8   esp: c1ef3be4
ds: 0018   es: 0018   ss: 0018
Process gnome-terminal (pid: 3950, process nr: 42, stackpage=c1ef3000)
Stack: c1ef2000 c2b9e220 00000296 c1ef2000 c2b9e220 00000001 c0117081
c1ef3c68
       c1ef2000 0000c000 c1ef3d08 00000020 c1ef2000 c0109898 0000000b
c1ef3c68
       c01d9b76 c01db50e 00000000 00000000 c010eb1c c01db50e c1ef3c68
c6550000
Call Trace: [<c0117081>] [<c0109898>] [<c01d9b76>] [<c01db50e>]
[<c010eb1c>] [<c01db50e>] [<c017cea8>]
       [<c0109485>] [<c012043f>] [<c0110010>] [<c0164ecc>] [<c01ca48b>]
[<c0165031>] [<c01c9fbb>] [<c0164f82>]
       [<c010a3fe>] [<c010a1c0>] [<c010a520>] [<c010a204>] [<c0100018>]
[<c0117f19>] [<c010a537>] [<c010a204>]
       [<c01137eb>] [<c010eab0>] [<c01db48a>] [<c0109485>] [<c012043f>]
[<c0164ecc>] [<c016468f>] [<c0164903>]
       [<c01878cc>] [<c01879b6>] [<c01878cc>] [<c01b14b5>] [<c0162ac0>]
[<c01878cc>] [<c0162cce>] [<c0124b47>]
       [<c0162c3c>] [<c0109374>]
Code: c7 05 00 00 00 00 00 00 00 00 8d 65 e8 5b 5e 5f 89 ec 5d c3

>>EIP; c0110b36 <schedule+26e/284>   <=====
Trace; c0117081 <do_exit+265/26c>
Trace; c0109898 <die_if_no_fixup+0/40> 
Trace; c01d9b76 <stext_lock+18aa/3354>
Trace; c01db50e <stext_lock+3242/3354>
Trace; c010eb1c <do_page_fault+2c4/3b0>  
Trace; c01db50e <stext_lock+3242/3354>
Trace; c017cea8 <udp_getfrag+0/c4>  
Trace; c0109485 <error_code+2d/34>
Trace; c012043f <kmem_cache_alloc+23/124>  
Trace; c0110010 <do_sigaction+154/160>
Trace; c0164ecc <alloc_skb+58/dc>
Trace; c01ca48b <ei_receive+1d7/328>  
Trace; c0165031 <__kfree_skb+a1/a8> 
Trace; c01c9fbb <ei_interrupt+e7/1d4>
Trace; c0164f82 <kfree_skbmem+32/40>
Trace; c010a3fe <handle_IRQ_event+36/6c>
Trace; c010a1c0 <do_8259A_IRQ+80/ac>
Trace; c010a520 <do_IRQ+24/40>
Trace; c010a204 <common_interrupt+18/20>
Trace; c0100018 <startup_32+18/11e>
Trace; c0117f19 <do_bottom_half+25/64>
Trace; c010a537 <do_IRQ+3b/40>
Trace; c010a204 <common_interrupt+18/20>
Trace; c01137eb <printk+14f/16c>
Trace; c010eab0 <do_page_fault+258/3b0>
Trace; c01db48a <stext_lock+31be/3354>
Trace; c0109485 <error_code+2d/34>
Trace; c012043f <kmem_cache_alloc+23/124>
Trace; c0164ecc <alloc_skb+58/dc> 
Trace; c016468f <sock_wmalloc+23/50>
Trace; c0164903 <sock_alloc_send_skb+63/a8>
Trace; c01878cc <unix_stream_sendmsg+0/260>  
Trace; c01879b6 <unix_stream_sendmsg+ea/260>
Trace; c01878cc <unix_stream_sendmsg+0/260>
Trace; c01b14b5 <pty_unthrottle+49/58>
Trace; c0162ac0 <sock_sendmsg+88/ac>
Trace; c01878cc <unix_stream_sendmsg+0/260>
Trace; c01879b6 <unix_stream_sendmsg+ea/260>
Trace; c01878cc <unix_stream_sendmsg+0/260>
Trace; c01b14b5 <pty_unthrottle+49/58>
Trace; c0162ac0 <sock_sendmsg+88/ac>
Trace; c01878cc <unix_stream_sendmsg+0/260>
Trace; c0162cce <sock_write+92/9c>  
Trace; c0124b47 <sys_write+db/100>
Trace; c0162c3c <sock_write+0/9c>   
Trace; c0109374 <system_call+34/38>
Code;  c0110b36 <schedule+26e/284>
00000000 <_EIP>:
Code;  c0110b36 <schedule+26e/284>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0110b3d <schedule+275/284>
   7:   00 00 00
Code;  c0110b40 <schedule+278/284>
   a:   8d 65 e8                  lea    0xffffffe8(%ebp),%esp
Code;  c0110b43 <schedule+27b/284>
   d:   5b                        pop    %ebx
Code;  c0110b44 <schedule+27c/284>
   e:   5e                        pop    %esi
Code;  c0110b45 <schedule+27d/284>
   f:   5f                        pop    %edi
Code;  c0110b46 <schedule+27e/284>
  10:   89 ec                     mov    %ebp,%esp
Code;  c0110b48 <schedule+280/284>
  12:   5d                        pop    %ebp
Code;  c0110b49 <schedule+281/284>
  13:   c3                        ret

if anymore info is required mail me
although i am not sure what was running at the time
of the machine crashing

thanks
	James

-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
 12:50am  up 22 days,  8:35,  4 users,  load average: 0.00, 0.12, 0.41

---1463811583-878053310-982976695=:1317
Content-Type: APPLICATION/x-gzip; name="opps.txt.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0102240104550.1317@cyrix.home>
Content-Description: 
Content-Disposition: attachment; filename="opps.txt.gz"

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
xi3ibwMA
---1463811583-878053310-982976695=:1317--
