Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbTGCJbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTGCJbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 05:31:21 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:44482 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S265648AbTGCJbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 05:31:20 -0400
Date: Thu, 3 Jul 2003 11:45:45 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] EXPORT_SYMBOL(complete_all);
Message-ID: <20030703094545.GD12411@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi,

 Is there a reason not to export 'complete_all'?

 It would be handy to have for modules.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="export_complete_all.diff"

Index: kernel/ksyms.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/ksyms.c,v
retrieving revision 1.209
diff -u -r1.209 ksyms.c
--- kernel/ksyms.c	21 Jun 2003 16:20:40 -0000	1.209
+++ kernel/ksyms.c	3 Jul 2003 08:25:50 -0000
@@ -416,6 +416,7 @@
 /* completion handling */
 EXPORT_SYMBOL(wait_for_completion);
 EXPORT_SYMBOL(complete);
+EXPORT_SYMBOL(complete_all);
 
 /* The notion of irq probe/assignment is foreign to S/390 */
 

--IJpNTDwzlM2Ie8A6--
