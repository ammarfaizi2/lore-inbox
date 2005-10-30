Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVJ3Nkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVJ3Nkt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 08:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVJ3Nkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 08:40:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53182 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750835AbVJ3Nks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 08:40:48 -0500
Date: Sun, 30 Oct 2005 14:41:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: art@usfltd.com, linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43 BogoMIPS) problem with bogometer ?
Message-ID: <20051030134108.GA13564@elte.hu>
References: <200510281828.AA38666812@usfltd.com> <1130544313.6169.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130544313.6169.57.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 2005-10-28 at 18:28 -0500, art wrote:
> > kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43 BogoMIPS) problem with bogometer ?
> > 
> > kernel-2.6.14-rc5-rt7 -- Calibrating delay using timer specific routine.. 604.62 BogoMIPS (lpj=302311)
> > 
> > kernel-2.6.14-rc5 -- Calibrating delay using timer specific routine.. 6024.43 BogoMIPS (lpj=12048877)
> 
> Already been fixed and will be out in Ingo's next release.  Before 
> high-res was activated, the ktimers was causing jiffies to go up 
> faster than HZ and this caused bad calculations of BogoMIPS.  So for 
> now just sit back and relax, it doesn't harm anything right now. :)

yeah. Should be fixed in 2.6.14-rt1.

	Ingo
