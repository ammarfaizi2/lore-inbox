Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUJ3M7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUJ3M7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 08:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUJ3M7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 08:59:03 -0400
Received: from imap.gmx.net ([213.165.64.20]:50069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261155AbUJ3M7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 08:59:00 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 15:16:17 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030151617.1bc6288d@mango.fruits.de>
In-Reply-To: <20041030112805.GB23493@elte.hu>
References: <20041029170948.GA13727@elte.hu>
	<20041029193303.7d3990b4@mango.fruits.de>
	<20041029172151.GB16276@elte.hu>
	<20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<20041030003122.03bcf01b@mango.fruits.de>
	<1099107364.1551.7.camel@krustophenia.net>
	<20041030112805.GB23493@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 13:28:05 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > I think there was a patch posted to the JACK mailing list to print
> > from a separate thread, I will look into this.
> 
> that would be the better longterm solution.

afaik jack should ony print from the RT thread when something bad happened
(like an xrun), so in normal operation this shouldn't make problems. but i'm
not sure. maybe paul knows more.

flo
