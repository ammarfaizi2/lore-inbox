Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUH3BzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUH3BzP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUH3BzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:55:15 -0400
Received: from jade.spiritone.com ([216.99.193.136]:25036 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268440AbUH3BzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:55:03 -0400
Date: Sun, 29 Aug 2004 18:54:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc1-mm1 can't compile a kernel
Message-ID: <114120000.1093830897@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to crap out with file corruption partway through, saying things
like:

ld -m elf_i386  -r -o utilities.o utalloc.o utcopy.o utdebug.o utdelete.o uteval.o utglobal.o utinit.o utmath.o utmisc.o utobject.o utxface.o
uteval.o: file not recognized: File truncated

2.6.9-rc1 seems to work fine. You got any likely candidates to try backing
out / trying separately? Else I guess I'll try linus.patch.

(test is just compiling 2.4.17 on the NUMA-Q).

But hey ... it makes my kernbench times super-whizzy-fast! ;-)

M.


