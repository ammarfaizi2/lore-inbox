Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUEEJaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUEEJaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUEEJaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:30:52 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6077 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264296AbUEEJat convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:30:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16536.46148.924407.411523@alkaid.it.uu.se>
Date: Wed, 5 May 2004 11:30:44 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
Cc: linux-kernel@vger.kernel.org, m.c.p@kernel.linux-systeme.com
Subject: Re: Linux 2.4.27-pre2 (gcc-3.4.0)
In-Reply-To: <20040505101553.7110da0c.rmrmg@wp.pl>
References: <20040504211939.79ed1e6f.rmrmg@wp.pl>
	<200405042146.40404@WOLK>
	<20040504220325.25516d8f.rmrmg@wp.pl>
	<20040505.083644.241899480.rene@rocklinux-consulting.de>
	<20040505101553.7110da0c.rmrmg@wp.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafa³ 'rmrmg' Roszak writes:
 > begin  Rene Rebe <rene@rocklinux-consulting.de> quote:
 > 
 > > It is for 2.4.26 - but should apply mostly to 2.4.27-pre2, too - I
 > > have not yet booted the resulting kernel, soo ....
 > 
 > patching file kernel/sysctl.c
 > Hunk #1 succeeded at 879 (offset 3 lines).
 > Hunk #3 succeeded at 1133 (offset 3 lines).
 > patching file lib/brlock.c
 > patching file lib/crc32.c
 > patching file lib/rwsem.c
 > patching file lib/string.c
 > patching file mm/filemap.c
 > patching file mm/memory.c
 > patching file mm/page_alloc.c
 > Hunk #1 FAILED at 82.
 > Hunk #2 succeeded at 241 (offset 41 lines).
 > Hunk #4 succeeded at 295 (offset 41 lines).
 > Hunk #6 succeeded at 486 (offset 41 lines).
 > Hunk #8 succeeded at 509 (offset 41 lines).
 > 1 out of 8 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej

Read the archives, a solution has been available since last week. Use:
http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre2

This has been throughly tested on i386 and x86_64 UP and SMP, and ppc UP,
although I have not verified drivers I don't use myself.
