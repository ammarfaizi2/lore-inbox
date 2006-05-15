Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWEOCOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWEOCOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 22:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWEOCOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 22:14:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbWEOCOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 22:14:15 -0400
Date: Sun, 14 May 2006 19:11:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] i386/x86-64 Add nmi watchdog support for new Intel CPUs
Message-Id: <20060514191101.45982cc0.akpm@osdl.org>
In-Reply-To: <20060514185023.A16695@unix-os.sc.intel.com>
References: <20060514185023.A16695@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
> --- linux-2.6.17-rc4/arch/i386/kernel/nmi.c	2006-05-11 17:23:13.000000000 -0700
>  +++ linux-2.6.17-rc4-nmi/arch/i386/kernel/nmi.c	2006-05-12 17:47:48.000000000 -0700
>   
> ...
>
>  +static void disable_intel_arch_watchdog(void)

Should this code be moved to arch/i386/kernel/cpu/intel.c?
