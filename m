Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUJKUgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUJKUgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbUJKUgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:36:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37860 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269233AbUJKUgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:36:21 -0400
Subject: Re: 2.6.9-rc4-mm1 HPET compile problems on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20041011125421.106eff07.akpm@osdl.org>
References: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011125421.106eff07.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1097526413.12861.374.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 13:26:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 12:54, Andrew Morton wrote:

> 
> I assume you have CONFIG_HPET=n and CONFIG_HPET_TIMER=n?
> 
> Andi, what's going on here?  Should the hpet functions in
> arch/x86_64/kernel/time.c be inside CONFIG_HPET_TIMER?

I haven't enable HPET, but autoconf.h gets 

# grep HPET autoconf.h
#define CONFIG_HPET_TIMER 1
#define CONFIG_HPET_EMULATE_RTC 1

# grep HPET .config
# CONFIG_HPET is not set

Thanks,
Badari

