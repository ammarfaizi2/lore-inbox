Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVBCVcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVBCVcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVBCVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:32:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:29120 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261690AbVBCVa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:30:27 -0500
Date: Thu, 3 Feb 2005 22:30:26 +0100
From: Andi Kleen <ak@suse.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, vojtech@suse.cz
Subject: Re: i386 HPET code
Message-ID: <20050203213026.GF3181@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 06:28:27AM -0800, Pallipadi, Venkatesh wrote:
> 
> Hi John, Andrew,
> 
> 
> Can you check whether only the following change makes the problem go
> away. If yes, then it looks like a hardware issue.
> 
> >	hpet_writel(hpet_tick, HPET_T0_CMP);
> >+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */


Ask Vojtech (cced), he wrote the x86-64 HPET code.

-Andi
