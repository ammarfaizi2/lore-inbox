Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUJKVDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUJKVDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUJKVDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:03:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:2254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269251AbUJKVDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:03:19 -0400
Date: Mon, 11 Oct 2004 14:06:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 HPET compile problems on AMD64
Message-Id: <20041011140641.69c2f120.akpm@osdl.org>
In-Reply-To: <1097526413.12861.374.camel@dyn318077bld.beaverton.ibm.com>
References: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com>
	<20041011125421.106eff07.akpm@osdl.org>
	<1097526413.12861.374.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I haven't enable HPET, but autoconf.h gets 
> 
> # grep HPET autoconf.h
> #define CONFIG_HPET_TIMER 1
> #define CONFIG_HPET_EMULATE_RTC 1
> 
> # grep HPET .config
> # CONFIG_HPET is not set

Something screwed up then.  Do a `make oldconfig', try a `make clean'.  I
can't find a way to make the above happen.
