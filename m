Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTEEU5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTEEU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:57:45 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:4258 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261360AbTEEU5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:57:38 -0400
Date: Mon, 05 May 2003 14:10:02 -0700
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: Re: Announce: kdb v4.2 is available for kernel 2.4.20,
 i386	and	ia64 [and sparc64 now]
In-reply-to: <1052152943.4374.39.camel@biznatch>
To: Keith Owens <kaos@sgi.com>
Cc: kdb@oss.sgi.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1052169002.4374.142.camel@biznatch>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <11249.1051859696@kao2.melbourne.sgi.com>
 <1052152943.4374.39.camel@biznatch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 09:42, Thomas Duffy wrote:
> This patch is needed as part of kdb common to get sparc64 kdb to build.
> 
> * include/linux/kdb.h references task_struct, needs to include sched.h
> * kdb/kdbmain.c #define's WRAP already defined in
>      include/asm-sparc64/termbits.h

Oops, guess original sent was too big for lists.  This time, include
link to patch.

Attached is a (link to a) forward port of the sparc64 kdb patch to v4.2
of kdb.  It is still rough around the edges, but it at least builds and
boots and is somewhat usable.

You must apply the kdb common patch and the patch to kdb common I sent
earlier to get it to build properly.

Enjoy!

http://www.dslextreme.com/users/tomduffy/kdb-v4.2-2.4.20-sparc64-1.bz2

-tduffy

-- 
Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>

