Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVKPBln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVKPBln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVKPBln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:41:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932261AbVKPBlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:41:42 -0500
Date: Tue, 15 Nov 2005 17:41:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       mnutter@us.ibm.com, arndb@de.ibm.com
Subject: Re: [PATCH 1/5] spufs: The SPU file system, base
Message-Id: <20051115174145.70f37501.akpm@osdl.org>
In-Reply-To: <20051115210408.327453000@localhost>
References: <20051115205347.395355000@localhost>
	<20051115210408.327453000@localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:
>
> This is the current version of the spu file system, used
> for driving SPEs on the Cell Broadband Engine.

+EXPORT_SYMBOL_GPL(hash_page);
+EXPORT_SYMBOL(spu_alloc);
+EXPORT_SYMBOL(spu_free);
+EXPORT_SYMBOL(spu_run);
+EXPORT_SYMBOL(spu_ibox_read);
+EXPORT_SYMBOL(spu_wbox_write);
+EXPORT_SYMBOL_GPL(register_spu_syscalls);
+EXPORT_SYMBOL_GPL(unregister_spu_syscalls);
-EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */
+EXPORT_SYMBOL_GPL(__handle_mm_fault);

A strange mixture of GPL and non-GPL.   What's the thinking here?
