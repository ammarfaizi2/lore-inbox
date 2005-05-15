Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVEOLce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVEOLce (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 07:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVEOLce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 07:32:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15376 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261562AbVEOLc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 07:32:29 -0400
Date: Sun, 15 May 2005 13:32:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       Martin Bligh <mbligh@aracnet.com>
Subject: [-mm patch] arch/i386/Kconfig: SELECT_MEMORY_MODEL -> ARCH_SELECT_MEMORY_MODEL
Message-ID: <20050515113224.GP16549@stusta.de>
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc3-mm3:
>...
> +sparsemem-memory-model-for-i386.patch
>...
>  More sparsemem stuff
>...

As far as I understand it, the following additional patch makes it look 
more as it was intended.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc4-mm1-full/arch/i386/Kconfig.old	2005-05-15 13:27:59.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/arch/i386/Kconfig	2005-05-15 13:28:10.000000000 +0200
@@ -794,7 +794,7 @@
 	def_bool y
 	depends on NUMA
 
-config SELECT_MEMORY_MODEL
+config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SPARSEMEM_ENABLE
 
