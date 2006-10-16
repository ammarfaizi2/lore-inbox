Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWJPUGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWJPUGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWJPUGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:06:09 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:9379 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1750801AbWJPUGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:06:07 -0400
Date: Mon, 16 Oct 2006 22:06:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nicholas Miell <nmiell@comcast.net>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Sam Ravnborg <sam@uranus.ravnborg.org>
Subject: Re: [build bug] x86_64, -git: Error: unknown pseudo-op: `.cfi_signal_frame'
Message-ID: <20061016200606.GB32232@uranus.ravnborg.org>
References: <20061016061037.GA12020@elte.hu> <1160980603.2388.9.camel@entropy> <20061016063602.GA4392@elte.hu> <20061016064300.GA5839@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016064300.GA5839@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 08:43:00AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > Note that i override 'CC' instead of specifying a 'CROSS' prefix. I 
> > suspect this means as-instr does not switch over to the 
> > cross-environment and thus mis-detected the gas version?
> 
> this did not solve it either - it seems if both CROSS and CC are set 
> then CC overrides it and CROSS is ignored? Removing the CC override 
> solved the problem. But how do i insert the 'distcc' that way? Seems 
> like a Kbuild breakage to me.

I will try to take a look when I'm back from vacation.
In few hours I'm leaving of for France for 8 days with the family.
If someone else beats me why I'm away it would be fine!

	Sam
