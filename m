Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTFKPLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTFKPLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:11:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:687 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262352AbTFKPLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:11:30 -0400
Date: Wed, 11 Jun 2003 08:10:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 800] New: 2.5.70-bkcurrent - flood of "scheduling while atomic!" and panic on boot
Message-ID: <47240000.1055344240@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: 2.5.70-bkcurrent - flood of "scheduling while atomic!"
                    and panic on boot
    Kernel Version: 2.5.70-bkcurrent
            Status: NEW
          Severity: blocking
             Owner: rml@tech9.net
         Submitter: plars@austin.ibm.com


Distribution:
RH7.3
Hardware Environment:
UP PIII-766, 256MB, IDE

Software Environment:
2.5.70-bkcurrent (config attached), EXT3, gcc 2.96

Problem Description:
On boot, I get a flood of "bad: scheduling while atomic!" messages, followed by
this panic:
Unable to handle kernel paging request at virtual address 40000b50
 printing eip:
40000b50
*pde = 00000000
Oops: 0004 [#1]
CPU:    0
EIP:    0073:[<40000b50>]    Not tainted
EFLAGS: 00010246
EIP is at 0x40000b50
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: bffffed0
ds: 007b   es: 007b   ss: 007b
Process init (pid: 1, threadinfo=c128e000 task=c1297440)
 <0>Kernel panic: Attempted to kill init!

Steps to reproduce:
Boot

