Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTF1OR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbTF1OR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 10:17:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42884 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265225AbTF1OR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 10:17:27 -0400
Date: Sat, 28 Jun 2003 07:31:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.73-mm1 falling over in SDET
Message-ID: <45120000.1056810681@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The killer SDET has got you, but this is all I got from the chewed
remains. Maybe the EIP is enough? ;-) I guess that's a NULL ptr
dereference, though garbled somewhat.

Unable to handle kernel <1pa>Uginnabgl re eqtoue hsta ndatle  vikertrnuaell  NadULdrL espos inaftecr71 d11er0
er penricent iantg v eiirtp:ua            ef
 cad01drc4es37s a             l
000*0pd00e 0     0
00 p00ri00nt00in
g Oeiopps: 0000 [#1]
SMP 
CPU:    -266755620
EIP:    0060:[<c01c437a>]    Not tainted VLI
EFLAGS: 00010083
EIP is at drive_stat_acct+0x76/0xcc
eax: c0668770   ebx: ee0f7580   ecx: f019a000   edx: ef6089a0
esi: 00000001   edi: 00000400   ebp: 00001055   esp: f019a2a8
ds: 007b   es: 007b   ss: 0068
Unable to handle kernel NULL pointer dereference at virtual address 0000005c
 printing eip:
c01163c0
*pde = 00104001
*pte = 00000000

