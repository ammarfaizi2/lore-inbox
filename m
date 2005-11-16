Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVKPURV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVKPURV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVKPURV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:17:21 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:4762 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932577AbVKPURV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:17:21 -0500
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5bdc1c8b0511161154y374b131jaa6c78badc221dd0@mail.gmail.com>
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
	 <200511161802.47244.s0348365@sms.ed.ac.uk>
	 <5bdc1c8b0511161025q20569fa4hd8c187503e9af1c2@mail.gmail.com>
	 <200511161849.51319.s0348365@sms.ed.ac.uk>
	 <5bdc1c8b0511161154y374b131jaa6c78badc221dd0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 15:17:16 -0500
Message-Id: <1132172237.3008.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 11:54 -0800, Mark Knecht wrote:
> > The alternative is ATI's proprietary driver which probably already supports
> > your card.
> 
> Thanks. I'll see if this old guitar player can get all of that done.

Mark,

You should really decide whether you're more interested in 100% xrun
free audio performance OR better video performance and pursue one or the
other - if you try to work on these in parallel you'll find it's one
step forward, two steps back.  There have been many cases in the past
where video drivers ended up doing evil things that would ruin reliable
audio performance to get 0.1% better numbers on some Windows benchmark,
then the same bad behavior got ported over to Linux.  I'd be especially
cautious with the Radeon driver as much of it seems to be reverse
engineered.  And if you read the "X spinning in the kernel" thread you
see that apparently these GPUs can "crash" (!) in which case you seem to
be screwed.

Lee

