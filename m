Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVGPNvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVGPNvl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGPNvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:51:40 -0400
Received: from cpu2485.adsl.bellglobal.com ([207.236.16.208]:53483 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261614AbVGPNvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:51:08 -0400
Date: Fri, 15 Jul 2005 17:41:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, cw@f00f.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715154134.GA1776@elf.ucw.cz>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713134857.354e697c.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Alan tested it and said that 250HZ does not save much power anyway.
> 
> Len Brown, a year ago: "The bottom line number to laptop users is battery
> lifetime.  Just today somebody complained to me that Windows gets twice the
> battery life that Linux does."
> 
> And "Maybe I can get Andy Grover over in the moble lab to get some time on
> that fancy power measurement setup they have...
> 
> "My expectation is if we want to beat the competition, we'll want the
> ability to go *under* 100Hz."
> 
> But then, power consumption of the display should preponderate, so it's not
> clear.
> 
> Len, any updates on the relationship between HZ and power consumption?

Last time I checked, HZ=100 to HZ=1000 difference was about 1W, about
twice as much as disk spinning up vs. disk spinned down.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
