Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUCXMPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 07:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUCXMPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 07:15:31 -0500
Received: from linux-bt.org ([217.160.111.169]:10146 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263301AbUCXMPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 07:15:30 -0500
Subject: Compile problem on sparc64
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080130448.2515.108.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 13:15:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using Debian Sid with GCC 3.3.3 (Debian 20040320) and I got the
following error on my sparc64 platform while compiling the latest
Bitkeeper sources from 2.6:

  CC      arch/sparc64/kernel/sparc64_ksyms.o
In file included from arch/sparc64/kernel/sparc64_ksyms.c:48:
include/asm/pgalloc.h: In function `free_pgd_fast':
include/asm/pgalloc.h:41: warning: use of cast expressions as lvalues is deprecated
include/asm/pgalloc.h:45: warning: use of cast expressions as lvalues is deprecated
include/asm/pgalloc.h:45: warning: use of cast expressions as lvalues is deprecated
include/asm/pgalloc.h: In function `get_pgd_fast':
include/asm/pgalloc.h:65: warning: use of cast expressions as lvalues is deprecated
include/asm/pgalloc.h:65: warning: use of cast expressions as lvalues is deprecated
include/asm/pgalloc.h:79: warning: use of cast expressions as lvalues is deprecated
include/asm/pgalloc.h:79: warning: use of cast expressions as lvalues is deprecated
include/asm/pgalloc.h:82: warning: use of cast expressions as lvalues is deprecated

Regards

Marcel


