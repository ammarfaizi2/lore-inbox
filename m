Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263394AbVBDT3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbVBDT3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbVBDT3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:29:08 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:29671 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S266552AbVBDT2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:28:16 -0500
Date: Fri, 4 Feb 2005 20:28:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: i386 HPET code
Message-ID: <20050204192830.GB5038@ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <20050203213026.GF3181@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203213026.GF3181@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:30:26PM +0100, Andi Kleen wrote:
> On Thu, Feb 03, 2005 at 06:28:27AM -0800, Pallipadi, Venkatesh wrote:
> > 
> > Hi John, Andrew,
> > 
> > 
> > Can you check whether only the following change makes the problem go
> > away. If yes, then it looks like a hardware issue.
> > 
> > >	hpet_writel(hpet_tick, HPET_T0_CMP);
> > >+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
> 
> 
> Ask Vojtech (cced), he wrote the x86-64 HPET code.
 
Can you add some background of the thread?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
