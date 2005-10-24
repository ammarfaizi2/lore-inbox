Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVJXUBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVJXUBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVJXUBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:01:42 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:49924 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751249AbVJXUBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:01:42 -0400
Date: Mon, 24 Oct 2005 15:54:07 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
Subject: Re: [PATCH 2.6.14-rc5-mm1] UML: fix compile part-1
Message-ID: <20051024195407.GA9106@ccure.user-mode-linux.org>
References: <E1EU4es-0005l0-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EU4es-0005l0-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 05:54:46PM +0200, Miklos Szeredi wrote:
> This patch fixes the following compile error:
> 
>   CC      arch/um/kernel/syscall_kern.o
> In file included from arch/um/kernel/syscall_kern.c:22:
> arch/um/include/sysdep/syscalls.h:14: error: conflicting types for `sys_ptrace'
> include/linux/syscalls.h:494: error: previous declaration of `sys_ptrace'
> 
> Don't know if it's the correct fix, but result seems to work fine for
> me.
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Acked-By: Jeff Dike <jdike@addtoit.com>

				Jeff
