Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUCKSIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUCKSIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:08:04 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:18379 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261626AbUCKSIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:08:01 -0500
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
From: "Yury V. Umanets" <umka@namesys.com>
To: Brad Laue <brad@brad-x.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4050A047.9030603@brad-x.com>
References: <404F85A6.6070505@brad-x.com>
	 <20040310155712.7472e31c.akpm@osdl.org> <4050271C.3070103@brad-x.com>
	 <40503120.9000008@brad-x.com>  <20040311020832.1aa25177.akpm@osdl.org>
	 <1079013947.24999.17.camel@firefly>  <4050A047.9030603@brad-x.com>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1079028562.31103.1.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 11 Mar 2004 20:09:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 19:22, Brad Laue wrote:
> Yury V. Umanets wrote:
> > Hello,
> > 
> > I have impression, that it is somehow related to ACPI and CPU
> > temperature. When CPU gets more hot ksoftirqd starts to eat 99% of CPU.
> > 
> > It may be checked by disabling ACPI (if enabled) and/or monitoring
> > /proc/acpi/thermal_zone/THRM/temperature (if any).
> 
> Happens on a system without ACPI or Power Management of any kind enabled 
> though.
> 
> Brad
Then have you seen clear dependence of ksoftirqd getting crazy on system
load? Or something else?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
umka

