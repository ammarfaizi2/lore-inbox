Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752043AbWHNSUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbWHNSUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbWHNSUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:20:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752043AbWHNSUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:20:14 -0400
Date: Mon, 14 Aug 2006 11:15:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060814111501.874177bf.akpm@osdl.org>
In-Reply-To: <200608141954.29656.rjw@sisk.pl>
References: <20060813012454.f1d52189.akpm@osdl.org>
	<200608141954.29656.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 19:54:29 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 13 August 2006 10:24, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > 
> 
> This patch:
> 
> simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
> 
> makes my x86_64 SMP box (dual-core Athlon 64 on an ULi-based AsRock mobo) run
> _very_ slow (it would take tens of minutes to boot the box if I were as
> patient as to wait for that).
> 
> Strangely enough, on a non-SMP box I have tested it on it works just fine.
> 

Thanks.  I dropped a reversion patch into
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/hot-fixes/


