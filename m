Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbUKZX5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbUKZX5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbUKZX4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:56:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26565 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263085AbUKZTmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:42:54 -0500
Date: Thu, 25 Nov 2004 18:02:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041125170209.GA25187@elte.hu>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com> <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com> <20041123115201.GA26714@elte.hu> <Pine.LNX.4.58.0411231206240.2146@gradall.private.brainfood.com> <20041124040604.GA13340@elte.hu> <Pine.LNX.4.58.0411240258460.2242@gradall.private.brainfood.com> <Pine.LNX.4.58.0411242122130.2173@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411242122130.2173@gradall.private.brainfood.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Heath <doogie@debian.org> wrote:

> > The symptoms still occur with 30-9.  I'll be trying rc2-mm2 over the
> > holiday.
> 
> Been running rc2-mm3 all day.  No issues yet.

thanks, this very much looks like an -RT related scheduling bug. I've
fixed a handful of scheduling problems in recent kernels (latest is
-31-7), you might want to try it. As far as i can tell, none of the bugs
fixed should cause the symptoms you are seeing, but maybe i'm wrong.

	Ingo
