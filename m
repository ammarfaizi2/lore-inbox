Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUADVzo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUADVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:55:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:26856 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264498AbUADVzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:55:42 -0500
Date: Sun, 4 Jan 2004 22:55:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Rob Love <rml@ximian.com>, linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <20040104215541.GB14982@ucw.cz>
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com> <1073233988.5225.9.camel@fur> <200401042034.i04KYm1P024587@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401042034.i04KYm1P024587@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 03:34:47PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 04 Jan 2004 11:33:08 EST, Rob Love said:
> 
> > I actually like this patch (perhaps since I have a P-M :) and think it
> > ought to go in, although I agree with others that the P-M is more of a
> > super-P3 than a scaled down P4.
> 
> Same here - /proc/cpuinfo says:
> 
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
> 
> Question for those more knowledgeable: Are there any known Pentium4 features
> enabled in the kernel with the PENTIUM4 options that simply Will Not Work on a
> 4M chipset (similar to a kernel built for a 586 not working on a 486), or are
> the differences limited to "sub-optimal performance" (for example, compiling
> with -mpentium4 results in code that runs but schedules less optimally)?  If
> there are, they must be fairly obscure corner cases, since I haven't knowingly
> hit one in several months.. :)
> 
> 2.7 timeframe - are there any added features of a P4 core we would *like*
> to exploit that aren't on a P4M?

Pentium 4M is a real Pentium 4 core, but with mobile features.

Pentium M is a beefed up Pentium III core, with mobile features and all
		Pentium 4 extra features (instructions, etc).

I think that answers your question.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
