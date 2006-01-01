Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWAAS5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWAAS5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 13:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWAAS5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 13:57:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49085 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932234AbWAAS5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 13:57:19 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Bradley Reed <bradreed1@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601011431.21303.s0348365@sms.ed.ac.uk>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <200601011431.21303.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 13:57:14 -0500
Message-Id: <1136141835.13079.49.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 14:31 +0000, Alistair John Strachan wrote:
> On Sunday 01 January 2006 09:14, Arjan van de Ven wrote:
> > On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
> > > I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
> > > they all work fine under 2.6.14 and 2.6.14-rt21/22.
> > >
> > > I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
> > > every video I try and play. Yes, I have nvidia modules loaded, so won't
> > > get much help, but thought someone might like to know.
> >
> > you know, you could have done a little bit more effort and reproduced
> > this without the binary crud... it's not that hard you know and it shows
> > that you actually care about the problem enough that you want to make it
> > worthwhile for people to look into it.
> 
> REPORTING-BUGS should probably be fixed to make the points you repeatedly have 
> to make. I agree 100% that people should not be reporting easily reproducible 
> bugs with proprietary drivers loaded; what's a reboot to them?
> 
> Let's add something to REPORTING-BUGS about tainted kernels and/or proprietary 
> drivers. A quick grep of this file from 2.6.15-rc6 gives me no hits for 
> "proprietary", "tainted" or "binary".
> 

Heh, wow, that's a serious omission.  It would explain why so many users
post tainted bug reports then act like we're fanatics for telling them
not to do that ;-)

Lee

