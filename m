Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTIHLFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 07:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTIHLFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 07:05:32 -0400
Received: from thor.65535.net ([216.17.104.19]:50185 "EHLO thor.65535.net")
	by vger.kernel.org with ESMTP id S261767AbTIHLFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 07:05:31 -0400
Date: Mon, 8 Sep 2003 04:04:24 -0700 (PDT)
From: Rus Foster <rghf@fsck.me.uk>
X-X-Sender: rghf@thor.65535.net
To: linux-kernel@vger.kernel.org
Subject: promblem compiling skas patch 
Message-ID: <20030908040409.B61909@thor.65535.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
OK I know the following isn't a standard part of the kernel, and if
someone could point me to somewhere more appropiate I would be greatfule.
Anyway I've downloaded a vanilla 2.4.21 and the skas patch from
http://kernels.usermodelinux.org/host/

However when compling at the end of make Bzimage I'm getting

        /usr/src/linux-2.4.21/arch/i386/lib/lib.a
/usr/src/linux-2.4.21/lib/lib.a /usr/src/linux-2.4.21/arch/i386/lib/lib.a
\
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o: In function `sys_ptrace':
arch/i386/kernel/kernel.o(.text+0x50c9): undefined reference to
`proc_mm_get_mm'
make: *** [vmlinux] Error 1


Can anyone shed any light on this?

Rus
 --
w: http://www.jvds.com  | Linux + FreeBSD Servers from $15/mo
e: rghf@jvds.com        | Totally Customizable Technology
t: +447919 373537	| Forums
t: 1-888-327-6330 	| http://forums.jvds.com


