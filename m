Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTHZTnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbTHZTnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:43:24 -0400
Received: from angband.namesys.com ([212.16.7.85]:44676 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262906AbTHZTnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:43:23 -0400
Date: Tue, 26 Aug 2003 23:43:21 +0400
From: Oleg Drokin <green@namesys.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Alex Zarochentsev <zam@namesys.com>, Steven Cole <elenstev@mesatop.com>,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 snapshot for August 26th.
Message-ID: <20030826194321.GA25730@namesys.com>
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov> <20030826182609.GO5448@backtop.namesys.com> <1061926566.1076.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061926566.1076.2.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Aug 26, 2003 at 09:36:07PM +0200, Felipe Alfaro Solana wrote:
> > Disable "reiser4 system call" (CONFIG_REISER4_FS_SYSCALL) support, it is 
> > not ready.
> [...]
> arch/i386/kernel/built-in.o(.data+0x7c4): In function `sys_call_table':
> : undefined reference to `sys_reiser4'
> make[2]: *** [.tmp_vmlinux1] Error 1
> make[1]: *** [vmlinux] Error 2
> [...]
> CONFIG_REISER4_FS=m

Building as module is also not yet supported.

Bye,
    Oleg
