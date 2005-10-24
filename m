Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVJXWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVJXWfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVJXWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:35:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751364AbVJXWfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:35:22 -0400
Date: Mon, 24 Oct 2005 15:35:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: Re: [PATCH 2.6.14-rc5-mm1] UML: fix compile part-1
Message-Id: <20051024153534.62315410.akpm@osdl.org>
In-Reply-To: <E1EU4es-0005l0-00@dorka.pomaz.szeredi.hu>
References: <E1EU4es-0005l0-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> --- linux.orig/arch/um/include/sysdep/syscalls.h	2005-10-04 14:18:29.000000000 +0200
> +++ linux/arch/um/include/sysdep/syscalls.h	2005-10-04 14:19:07.000000000 +0200

The patch didn't apply - arch/um/include/sysdep is a symlink, so it has the
same problem as patches against include/asm/*.

You really weanted to patch arch/um/include/sysdep-i386/syscalls.h
