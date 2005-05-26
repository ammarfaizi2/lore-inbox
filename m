Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVEZHpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVEZHpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEZHpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:45:17 -0400
Received: from smtp05.auna.com ([62.81.186.15]:30914 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261250AbVEZHo5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:44:57 -0400
Date: Thu, 26 May 2005 07:44:54 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc5-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org> (from akpm@osdl.org on
	Wed May 25 22:49:33 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117093494l.17165l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Thu, 26 May 2005 09:44:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.25, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/
> 
> 
> - Again, if there are patches in here which you think should be merged in
>   2.6.12, please point them out to me.
> 

I collected this from lkml:

--- linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c.old	2005-05-17 00:05:28.000000000 +0200
+++ linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-05-17 00:05:49.000000000 +0200
@@ -118,7 +118,7 @@
 };
 
 #define MAX_CACHE_LEAVES		4
-static unsigned short __devinitdata	num_cache_leaves;
+static unsigned short			num_cache_leaves;
 
 static int __devinit cpuid4_cache_lookup(int index, struct _cpuid4_info *this_leaf)
 {

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


