Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbTGJFwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268939AbTGJFwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:52:51 -0400
Received: from holomorphy.com ([66.224.33.161]:44975 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266275AbTGJFwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:52:50 -0400
Date: Wed, 9 Jul 2003 23:08:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Piet Delaney <piet@www.piet.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
Message-ID: <20030710060841.GQ15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <200307091106.00781.schlicht@uni-mannheim.de> <20030709021849.31eb3aec.akpm@osdl.org> <1057815890.22772.19.camel@www.piet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057815890.22772.19.camel@www.piet.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 10:44:50PM -0700, Piet Delaney wrote:
> I'll settle for Matt Mackall <mpm@selenic.com> fix for now:
>     +#define apm_save_cpus()        (current->cpus_allowed)
> I wonder why other, like Thomas Schlichter <schlicht@uni-mannheim.de>,
> had no problem with the CPU_MASK_NONE fix.
> I tried adding the #include <linux/cpumask.h> that Marc-Christian
> Petersen <m.c.p@wolk-project.de> sugested but it didn't help. Looks
> like Jan De Luyck <lkml@kcore.org> had a similar result. 

Ugh. Fixing.


-- wli
