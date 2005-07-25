Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVGYNrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVGYNrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 09:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVGYNrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 09:47:43 -0400
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:39395 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261218AbVGYNrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 09:47:42 -0400
From: Sheo Shanker Prasad <ssp@creativeresearch.org>
Organization: Creative Research Enterprises
To: linux-kernel@vger.kernel.org
Subject: Please help with following NUMA-related questions
Date: Mon, 25 Jul 2005 06:47:31 -0700
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507250647.31803.ssp@creativeresearch.org>
X-ELNK-Trace: c9e54813b5d7ed8a1e28108c03118538416dc04816f3191c115fc8fdc7d6bdcc0888c568f1c23271b4c15e11771f6bed350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.4.45.120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will greatly appreciate any help regarding the following matters:

(1) How to know whether my machine is NUMA-aware or not,

(2) Difference between memory bank interleaving and node interleaving

(3) When the BIOS asks me to set bank interleaving as AUTO, then it says that  
AUTO allows memory access to spread out over banks on the same node or across 
nodes decreasing memory access contentions. However, I have no idea when the 
memory access is spread over banks on the same node or across nodes. I also 
do not know how to tell the machine to access memory across the nodes or on 
the same node. I have no idea as to how the AUTO choice affects 
NUMA-awareness.

(4) The BIOS also tells me that I could choose bani interleaving as DISABLED. 
But I do not know what its implications are for NUMA awareness.

Here are other relevant details. I have a dual-Opteron 250 (2.4GHz) set in 
Tyan Thunder 2885 K8W with AMIBIOS version 2.05.

When I bought it last year, the machine was running under SuSE 9.1 Pro and the 
Linux kernel was 2.6.5-7.108-smp. At that time both the Hardware Info from 
YAST and /vat/log/messages were explicitly mentioning things :

Scanning NUMA topology in Northbridge 24
  <6>Number of nodes 2 (10010)
  <6>Node 0 MemBase 0000000000000000 Limit 000000007fffffff
  <6>Node 1 MemBase 0000000080000000 Limit 00000000cbff0000
  <6>Using node hash shift of 24

These messages indicated that NODE interleaving was off and the machine was 
NUMA-aware.

Then, after a few months, the motherboard failed and the machine was sent to 
the vendor for repair. It came back with SuSE 9.3 and the Linux kernel 
version 2.6.11.4-21.7-smp (geeko@buildhost) (gcc version 3.3.5 20050117 
(prerelease) (SUSE Linux)) #1 SMP Thu Jun 2 14:23:14 UTC 2005.


Now  both the Hardware Info from YAST and /vat/log/messages DO NOT mention 
NUMA anywhere, and I do not have anyway to check whether the 
NODE-Interleaving is OFF or ON. My difficulties are compounded because I do 
not know how to interpret the chipset related setting in the BIOS.

Currently, in the BIOS setting (Chipset->memory config -> Bank Interleaving), 
I am asked to choose between AUTO & DISABLED. No choice is offered for Node 
Interleaving.

The only guidance for the choice is that interleaving allows memory access to 
spread out over banks on the same node or across nodes decreasing memory 
access contentions. Nothing is mentioned about what happens when Interleaving 
is disabled. Furthermore, if I choose AUTO, then I do not know when the 
memory is spread out over banks on the same node or across nodes.

Any help will be greatly appreciated.

Thanking you in advance.

-- 
Best regards.

Sheo
(Sheo S. Prasad)
Creative Research Enterprises
6354 Camino del Lago
Pleasanton, CA 94566, USA
Voice Phone: (+1) 925 426-9341
Fax   Phone: (+1) 925 426-9417
e-mail: ssp@CreativeResearch.org

