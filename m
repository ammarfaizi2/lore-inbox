Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVANEYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVANEYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVANEYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:24:08 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:34658 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261901AbVANEYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:24:03 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <41E7468B.3050702@kolivas.org>
References: <1105669451.5402.38.camel@npiggin-nld.site>
	 <200501140240.j0E2esKG026962@localhost.localdomain>
	 <20050113191237.25b3962a.akpm@osdl.org>  <41E739F4.1030902@kolivas.org>
	 <1105673482.5402.58.camel@npiggin-nld.site>  <41E7468B.3050702@kolivas.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 15:23:58 +1100
Message-Id: <1105676638.5402.89.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 15:11 +1100, Con Kolivas wrote:
> Nick Piggin wrote:
> > It sounds to me like both your proposals may be too complex and not
> > sufficiently deterministic (I don't know for sure, maybe that's
> > exactly what the RT people want).
> 
> This is the solution already employed in the real world by OSX. It works
> well, and the audio people have told me they are happy with it.
> 

Alternatively, could you grant the required capabilities to use real
RT scheduling and not foul up the scheduler?

Or do a similar sort of thing with a userspace daemon that manages
priorities and watches CPU usage?

Basically I'd prefer not to put hacks in the (mainline) scheduler to
handle this pretty specific special case.

> > I could be completely off the rails though. I haven't really been
> > following this thread so please shoot me in my foot if I have put it
> > in my mouth.
> 
> If your foot is in your mouth and you ask me to shoot you in the foot it
> would blow your head off... Hmm it's tempting...
> 

Meeeow!



