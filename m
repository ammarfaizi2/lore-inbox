Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUFJCXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUFJCXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbUFJCXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:23:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:34283 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265977AbUFJCXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:23:17 -0400
Date: Wed, 9 Jun 2004 19:22:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phil Brunner <pbrunner1@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-Id: <20040609192232.4f7cb046.akpm@osdl.org>
In-Reply-To: <40C7C310.1010009@earthlink.net>
References: <20040609015001.31d249ca.akpm@osdl.org>
	<40C7C310.1010009@earthlink.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Brunner <pbrunner1@earthlink.net> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/
> > 
> Could not compile with CONFIG_X86_IO_APIC=y. Function call to 
> (undefined) mp_register_gsi in arch/i386/kernel/acpi/boot.c is the problem.
> 
> Code in arch/i386/kernel/mpparse.c may be the appropriate function 
> definition (?).

Today we fixed about 10^10^10 such bugs which people have been kindly
sending me (how hard is this?  The compiler tells you!).  This one is
probably solved.  Please send me the .config.
