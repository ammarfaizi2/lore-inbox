Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbUAHDAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAHDAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:00:24 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:53199 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S263545AbUAHDAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:00:19 -0500
To: linux-kernel@vger.kernel.org
Subject: Machine check on Alpha
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 08 Jan 2004 04:00:17 +0100
Message-ID: <yw1xad4z87r2.fsf@ford.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My Alpha SX164 suddenly printed this on the console:

CIA machine check: vector=0x670 pc=0xfffffc0000351b78 code=0x98
machine check type: processor detected hard error
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Does anyone know what this particular machine check means?

A little while earlier, this oops appeared.  I didn't have time to
run ksymoops.

Unable to handle kernel paging request at virtual address 0000000000000000
pdflush(2294): Oops 1
pc = [<fffffc000033e050>]  ra = [<fffffc000032c338>]  ps = 0007    Not tainted
v0 = 0000000000000000  t0 = fffffc00005f1bd8  t1 = 0000000000200000
t2 = fffffc00005f1d18  t3 = 0000000000000000  t4 = 0000000000000000
t5 = 0000000000000000  t6 = 0000000000200200  t7 = fffffc0025150000
s0 = fffffc00005f1b00  s1 = 0000000000000001  s2 = 0000000000000001
s3 = fffffc00006714c8  s4 = fffffc00005f6e68  s5 = 0000000000000400
s6 = fffffc00006714c8
a0 = fffffc00005f1b00  a1 = 0000000000000003  a2 = fffffc000059dda7
a3 = fffffc002514fff8  a4 = fffffc0000000008  a5 = 0000000000000000
t8 = 0000000000100100  t9 = 0000000000000000  t10= 0000000000000000
t11= 0000000000000000  pv = fffffc000033e010  at = 0000000000000000
gp = fffffc0000671b00  sp = fffffc002514ff58
Trace:fffffc000032c338 fffffc000032c3f4 fffffc000032c5b4 fffffc000034f494 
Code: b53e0008  40420402  a4a10140  a4830008  a4c30010  20e20200 <b4a40000> b4850008 

-- 
Måns Rullgård
mru@kth.se
