Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVH3RHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVH3RHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVH3RHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:07:32 -0400
Received: from mirapoint5.brutele.be ([212.68.199.150]:40006 "EHLO
	mirapoint5.brutele.be") by vger.kernel.org with ESMTP
	id S932227AbVH3RHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:07:31 -0400
Date: Tue, 30 Aug 2005 19:07:25 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.13 - 2/3 - Remove the deprecated function __check_region
Message-ID: <20050830170725.GA11011@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint5.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090205.43148FD4.005E-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi all, 
 
Here is the second patch for kernel 2.6.13 from Linus tree.

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>



--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="patch_remove_check_mem_region_in_include_linux_ioportH.diff"

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -114,7 +114,6 @@ extern struct resource * __request_regio
 
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
-#define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
 extern int __check_region(struct resource *, unsigned long, unsigned long);

--jRHKVT23PllUwdXP--

