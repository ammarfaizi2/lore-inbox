Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWG3UKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWG3UKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWG3UKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:10:17 -0400
Received: from colin.muc.de ([193.149.48.1]:26886 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932475AbWG3UKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:10:15 -0400
Date: 30 Jul 2006 22:10:05 +0200
Date: Sun, 30 Jul 2006 22:10:05 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, smurf@smurf.noris.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp,
       asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060730201005.GA85093@muc.de>
References: <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730020346.5d301bb5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess Matthias didn't test this patch.  Can we get some obviously-correct
> fix in place for 2.6.18?

So far we don't have any idea what the problem is on that system.

> It is a "CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03".

Was that on that system? I guess it could be checked for and TSC 
be forced off. It sounds like a real CPU bug however.

-Andi
