Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTFXTnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTFXTnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 15:43:20 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:10377
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S262033AbTFXTnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 15:43:18 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: Kernel Panic in 2.5.73-mm1 OOps part.
Date: Tue, 24 Jun 2003 13:31:57 -0600
Message-Id: <20030624191740.M38428@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Andrew:


    I have kernel panic when boot with kernel 2.5.73-mm1, in kernel 2.5.73
working good.

    Anex part the OOps:


    EPI: 0060:[<c20f480>]   not tainted VLI
    EFLAHS: 0010246
    EIP:   is at kobject_add+0xd0/0130
    eax: 736f70a3 ebx:736f705f  ecx:00000000   edx:ffff0001
    esi: 736f70a3 edi:dfd6653x  ebp:c157df40   esp:c157df24
    ds:  007b  es: 007b  ss:  0068

    Process:   swapper( pid:1, theaddinfo= c157c000 task = c157f880)
    
    Stack:

    c03ed505  00000059  dfd6653c  dfd80860  dfd66400 dfd653c  c157f75c
     
  
    Call Trace:

    [< c020f503>]  kobject_register+0x23/0x60
    [<             blk_register_queue+0x80/0xb0
                   nbd_init+0x1df/0x220
                   do_initcalls+0x2b/0xa0
                   init_workqueues+0x12/0x30
                   init+0x28/0x150
                   init+0x0/0x150
                   kernel_thread_helper+0x50/0xc

   Code: feff
   <0>Kernel Panic:  Attempted to kill init!


   Helpme please.

   Regards.


