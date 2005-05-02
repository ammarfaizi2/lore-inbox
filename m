Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVEBXur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVEBXur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVEBXur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:50:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:9880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261235AbVEBXun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:50:43 -0400
Date: Mon, 2 May 2005 16:51:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       ak@suse.de
Subject: Re: [patch 1/1] Uml: kludgy compilation fixes for x86-64 subarch
 modules support [for -mm]
Message-Id: <20050502165103.6d76f394.akpm@osdl.org>
In-Reply-To: <20050501184515.F1AA48D835@zion>
References: <20050501184515.F1AA48D835@zion>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:
>
> These are some trivial fixes for the x86-64 subarch module support. The only
> potential problem is that I have to modify arch/x86_64/kernel/module.c, to
> avoid copying the whole of it.
> 
> I can't use it verbatim because it depends on a special vmalloc-like area for
> modules, which for now (maybe that's to fix, I guess not) UML/x86-64 has not.
> I went the easy way and reused the i386 vmalloc()-based allocator.

Why is this "for -mm" and not for -linus?
