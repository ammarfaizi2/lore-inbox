Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTJEJ0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbTJEJ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:26:20 -0400
Received: from mail-5.tiscali.it ([195.130.225.151]:53943 "EHLO
	mail-5.tiscali.it") by vger.kernel.org with ESMTP id S263051AbTJEJ0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:26:17 -0400
Date: Sun, 5 Oct 2003 11:26:41 +0200
From: Daniele Bellucci <bellucda@tiscali.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test6-mm4
Message-ID: <20031005092641.GA4246@localhost.localdomain>
References: <20031005013326.3c103538.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005013326.3c103538.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It doesn't compile to me ...
too many undefined references to `ntohl/htonl/htons/...`

make all:
..
fs/built-in.o: In function `ext3_get_dev_journal':
/usr/src/linux-2.6.0-test6-mm4/fs/ext3/super.c:1533: undefined reference to `ntohl'
/usr/src/linux-2.6.0-test6-mm4/fs/ext3/super.c:1534: undefined reference to `ntohl'
fs/built-in.o: In function `journal_commit_transaction':
/usr/src/linux-2.6.0-test6-mm4/fs/jbd/commit.c:376: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/fs/jbd/commit.c:377: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/fs/jbd/commit.c:378: undefined reference to `htonl'
fs/built-in.o: In function `journal_commit_transaction':
/usr/src/linux-2.6.0-test6-mm4/include/linux/jbd.h:306: undefined reference to `htonl'
fs/built-in.o: In function `journal_commit_transaction':
/usr/src/linux-2.6.0-test6-mm4/fs/jbd/commit.c:444: undefined reference to `htonl'
fs/built-in.o:/usr/src/linux-2.6.0-test6-mm4/fs/jbd/commit.c:468: more undefined references to `htonl' follow
fs/built-in.o: In function `journal_recover':
/usr/src/linux-2.6.0-test6-mm4/fs/jbd/recovery.c:240: undefined reference to `ntohl'
fs/built-in.o: In function `do_one_pass':
/usr/src/linux-2.6.0-test6-mm4/fs/jbd/recovery.c:331: undefined reference to `ntohl'
net/built-in.o: In function `ip_rt_redirect':
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:981: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:981: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:981: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:981: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:981: undefined reference to `htonl'
net/built-in.o:/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:981: more undefined references to `htonl' follow
net/built-in.o: In function `ip_rt_frag_needed':
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1243: undefined reference to `ntohs'
net/built-in.o: In function `ip_route_input_mc':
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1448: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1448: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1448: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1448: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1448: undefined reference to `htonl'
net/built-in.o:/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1448: more undefined references to `htonl' follow
net/built-in.o: In function `ip_route_input_mc':
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1448: undefined reference to `htons'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1452: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1452: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1453: undefined reference to `htonl'
/usr/src/linux-2.6.0-test6-mm4/net/ipv4/route.c:1453: undefined reference to `htonl'
...
...
make: *** [.tmp_vmlinux1] Error 1





-- 



Daniele.


