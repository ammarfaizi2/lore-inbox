Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTDDEWj (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 23:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbTDDEWj (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:22:39 -0500
Received: from [210.22.78.238] ([210.22.78.238]:51177 "HELO trust-mart.com")
	by vger.kernel.org with SMTP id S261367AbTDDEWe (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:22:34 -0500
From: hv <hv@trust-mart.com.cn>
To: linux-kernel@vger.kernel.org
Subject: my 2.5.66-bk9 oops
Message-Id: <20030404123302.4656671c.hv@trust-mart.com.cn>
Organization: it-TM
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 3 Apr 2003 23:22:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
When I mount a iso file to /mnt/cdrom,I got this oops.
my kernel is 2.5.66-bk9 and loop is built as a module.


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0389d08
*pde = 00000000
Oops: 0002 [#3]
CPU:    0
EIP:    0060:[<c0389d08>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: f8bd0f4d   ecx: 00000000   edx: ee726000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: f4b3bff8
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 10923, threadinfo=f4b3a000 task=f0125280)
Stack: 00000000 00000000
Call Trace:
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
