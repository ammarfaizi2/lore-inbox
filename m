Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUJGVuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUJGVuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUJGVs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:48:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:31365 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268283AbUJGVqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:46:21 -0400
Date: Thu, 7 Oct 2004 23:46:17 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3: build problem on dual-Opteron w/ NUMA
Message-ID: <20041007214617.GC31558@wotan.suse.de>
References: <20041007015139.6f5b833b.akpm@osdl.org> <200410072301.39399.rjw@sisk.pl> <20041007144045.29e64ef0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007144045.29e64ef0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> akpm:/home/akpm> grep HPET 2.6.9-rc3-mm3-NUMA.config
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> # CONFIG_HPET is not set
> 
> I'll take a punt and assume that CONFIG_HPET_TIMER requires CONFIG_HPET.

Yes, thanks. Looks correct.

-Andi
