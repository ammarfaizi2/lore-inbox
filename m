Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTAWPfO>; Thu, 23 Jan 2003 10:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTAWPfO>; Thu, 23 Jan 2003 10:35:14 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:33682 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S265400AbTAWPfN>; Thu, 23 Jan 2003 10:35:13 -0500
Date: Thu, 23 Jan 2003 16:44:07 +0100
From: Brice Goglin <bgoglin@ens-lyon.fr>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.59] Export get_sb_pseudo
Message-ID: <20030123154407.GC27044@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

This very little patch exports the get_sb_pseudo symbol
(defined in fs/libfs.c) in kernel/ksyms.c to allow people
to create their own pseudo filesystem.

Regards

Brice Goglin
============
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
ENS Lyon
France

--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="export_get_sb_pseudo-2.5.59.diff"

diff -ruN v2.5.59/kernel/ksyms.c v2.5.59a/kernel/ksyms.c
--- v2.5.59/kernel/ksyms.c     Thu Jan 23 16:17:45 2003
+++ v2.5.59a/kernel/ksyms.c    Thu Jan 23 16:18:12 2003
@@ -332,6 +332,7 @@
 EXPORT_SYMBOL(sget);
 EXPORT_SYMBOL(set_anon_super);
 EXPORT_SYMBOL(do_select);
+EXPORT_SYMBOL(get_sb_pseudo);

 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);

--uh9ZiVrAOUUm9fzH--
