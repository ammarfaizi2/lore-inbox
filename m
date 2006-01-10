Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWAJHpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWAJHpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWAJHpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:45:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750857AbWAJHpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:45:54 -0500
Date: Mon, 9 Jan 2006 23:45:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@sgi.com>
Cc: hch@infradead.org, sam@ravnborg.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-Id: <20060109234532.78bda36a.akpm@osdl.org>
In-Reply-To: <43C2CFBD.8040901@sgi.com>
References: <20060109164214.GA10367@mars.ravnborg.org>
	<20060109164611.GA1382@infradead.org>
	<43C2CFBD.8040901@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It'd be nice to fix this:

bix:/usr/src/25> make fs/xfs/linux-2.6/xfs_iops.o
  SPLIT   include/linux/autoconf.h -> include/config/*
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  HOSTCC  scripts/genksyms/lex.o
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTLD  scripts/mod/modpost
scripts/Makefile.build:15: /usr/src/devel/fs/xfs/linux-2.6/Makefile: No such file or directory
make[1]: *** No rule to make target `/usr/src/devel/fs/xfs/linux-2.6/Makefile'.  Stop.
make: *** [fs/xfs/linux-2.6/xfs_iops.o] Error 2
