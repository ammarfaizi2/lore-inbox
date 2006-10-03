Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWJCRaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWJCRaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWJCRao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:30:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46309 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030350AbWJCRaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:30:35 -0400
Date: Tue, 3 Oct 2006 13:19:27 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 8/12] elf: Add ELFOSABI_STANDALONE to elf.h
Message-ID: <20061003171927.GH3164@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003170032.GA30036@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Add ELFOSABI_STANDALONE definition to elf.h

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 include/linux/elf.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN include/linux/elf.h~elf-Add-ELFOSABI_STANDALONE-to-elf.h include/linux/elf.h
--- linux-2.6.18-git17/include/linux/elf.h~elf-Add-ELFOSABI_STANDALONE-to-elf.h	2006-10-02 13:17:59.000000000 -0400
+++ linux-2.6.18-git17-root/include/linux/elf.h	2006-10-02 13:17:59.000000000 -0400
@@ -338,8 +338,9 @@ typedef struct elf64_shdr {
 #define EV_CURRENT	1
 #define EV_NUM		2
 
-#define ELFOSABI_NONE	0
-#define ELFOSABI_LINUX	3
+#define ELFOSABI_NONE		0
+#define ELFOSABI_LINUX		3
+#define ELFOSABI_STANDALONE	255
 
 #ifndef ELF_OSABI
 #define ELF_OSABI ELFOSABI_NONE
_
