Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTILFHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 01:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTILFHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 01:07:52 -0400
Received: from dp.samba.org ([66.70.73.150]:35790 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261693AbTILFH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 01:07:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Andries Brouwer <aebr@win.tue.nl>, Jakub Jelinek <jakub@redhat.com>,
       Dan Aloni <da-x@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: Re: [BK PATCH] One strdup() to rule them all 
In-reply-to: Your message of "Thu, 11 Sep 2003 23:12:45 -0400."
             <3F6139AD.6070603@pobox.com> 
Date: Fri, 12 Sep 2003 14:16:48 +1000
Message-Id: <20030912050729.331442C11B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F6139AD.6070603@pobox.com> you write:
> Of course, if we DO waste time on it, your implementation Rusty kicks 
> ass and takes steroids :)

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test5-bk2/MAINTAINERS working-2.6.0-test5-bk2-modules_txt_kconfig1/MAINTAINERS
--- linux-2.6.0-test5-bk2/MAINTAINERS	2003-09-09 10:34:22.000000000 +1000
+++ working-2.6.0-test5-bk2-modules_txt_kconfig1/MAINTAINERS	2003-09-12 14:15:42.000000000 +1000
@@ -1102,6 +1102,13 @@ W:	http://nfs.sourceforge.net/
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
+KSTRDUP
+P:	Kstrdup Core Team
+M:	kstrdup-core@ozlabs.org
+L:	kstrdup@linux.kernel.org
+W:	http://kstrdup.sourceforge.net/
+S:	Supported
+
 LANMEDIA WAN CARD DRIVER
 P:	Andrew Stanley-Jones
 M:	asj@lanmedia.com

Kill me now,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
