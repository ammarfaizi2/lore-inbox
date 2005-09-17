Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVIQJlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVIQJlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 05:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVIQJlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 05:41:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751000AbVIQJlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 05:41:52 -0400
Date: Sat, 17 Sep 2005 02:41:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: patrizio.bassi@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1 Critical bug: machine complete freeze
Message-Id: <20050917024116.6e16529b.akpm@osdl.org>
In-Reply-To: <432BE118.5090008@gmail.com>
References: <432BE118.5090008@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
>
> Hi.
> 
> i'm using 2.6.14-rc1.
> 
> 1 second after starting samba (3.0.20) machine freezes completly.
> no way to resume it, just hardware reset.
> 
> I can't provide backtraces or logs, there isn't a logged kernel panic, 
> nor other log.
> Immedially freezed.
> 
> 2.6.13 works.
> 
> Of course same smb.conf and same .config.
> 

Please enable CONFIG_DEBUG_SLAB, CONFIG_DEBUG_PAGE_ALLOC,
CONFIG_X86_LOCAL_APIC and add `nmi_watchdog=1' to the kernel boot command
line.

