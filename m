Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTHSKW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTHSKW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:22:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:41673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270014AbTHSKWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:22:25 -0400
Date: Tue, 19 Aug 2003 03:23:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Flameeyes <daps_mls@libero.it>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.0-test3-mm3
Message-Id: <20030819032350.55339908.akpm@osdl.org>
In-Reply-To: <1061287775.5995.7.camel@defiant.flameeyes>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	<1061287775.5995.7.camel@defiant.flameeyes>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flameeyes <daps_mls@libero.it> wrote:
>
> On Tue, 2003-08-19 at 10:38, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm3/
> 
> there's a problem with make xconfig:
> 
> defiant:/usr/src/linux-2.6.0-test3-mm3# make xconfig
>   CC      scripts/empty.o
>   MKELF   scripts/elfconfig.h
>   HOSTCC  scripts/file2alias.o
>   HOSTCC  scripts/modpost.o
>   HOSTLD  scripts/modpost
> make[1]: *** No rule to make target `scripts/kconfig/qconf.c', needed by
> `scripts/kconfig/qconf'.  Stop.
> make: *** [xconfig] Error 2

umm, Sam?

> 
> also, the ACPI entries seems vanished in the .config, and the menu is
> not accessible.
> With the old 2.6.0-test3-mm2 no problem at all.

You'll need to enable CONFIG_X86_LOCAL_APIC to work around this.

