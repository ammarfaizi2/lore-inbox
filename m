Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVCITQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVCITQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVCIS7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:59:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:19658 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262172AbVCIS7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:59:20 -0500
Date: Wed, 9 Mar 2005 10:58:40 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, yuasa@hh.iij4u.or.jp
Subject: Re: [patch 4/5] audit mips fix
Message-ID: <20050309185840.GC27268@kroah.com>
References: <200503042117.j24LHI7l017973@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042117.j24LHI7l017973@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:16:57PM -0800, akpm@osdl.org wrote:
> 
> From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> 
>   CC      arch/mips/kernel/ptrace.o
> arch/mips/kernel/ptrace.c: In function 'do_syscall_trace':
> arch/mips/kernel/ptrace.c:310: warning: implicit declaration of function 'audit_syscall_entry'
> arch/mips/kernel/ptrace.c:310: error: 'struct pt_regs' has no member named 'orig_eax'
> arch/mips/kernel/ptrace.c:314: warning: implicit declaration of function 'audit_syscall_exit'
> 
> Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Added to the -stable queue, thanks.

greg k-h

