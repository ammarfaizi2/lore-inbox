Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUG1Umf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUG1Umf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUG1Ume
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:42:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:64924 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263851AbUG1Umc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:42:32 -0400
Subject: Re: [patch] IRQ threads
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: karim@opersys.com, Scott Wood <scott@timesys.com>,
       Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040728202107.GA6952@nietzsche.lynx.com>
References: <20040727225040.GA4370@yoda.timesys>
	 <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe>
	 <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe>
	 <20040728202107.GA6952@nietzsche.lynx.com>
Content-Type: text/plain
Message-Id: <1091047369.791.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 16:42:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 16:21, Bill Huey wrote:
> On Wed, Jul 28, 2004 at 03:33:38PM -0400, Lee Revell wrote:
> > I am familiar with Adeos, as well as other hard-RT solutions for Linux. 
> > I did my homework before deciding that I do not in fact need hard-RT, so
> > I really am not interested in your flamewars, keep them on your RT
> > mailing lists.
> > 
> > The part that was obvious commercially motivated FUD (and which you
> > omitted) t in which you badmouth TimeSys and its services, then  Your
> > .sig states that you are a consultant specializing in realtime and
> > embedded Linux.
> 
> With that said, there's really two camps that are emerging in the real
> time Linux field, dual and single kernel. The single kernel work that's
> current being done could very well get Linux to being hard RT, assuming
> that you solve all of the technical problems with things like RCU,
> etc... in 2.6.
> 
> The dual kernels folks would be in less of position to VAR their own
> stuff and sell proprietary products if Linux were to get native hard RT
> performance if you accept that economic criteria. Who knows what the
> actual results will be.

As I understand it there will still be a place for the current hard-RT
Linux solutions, because even if I can get five nines latency better
than N, this is not good enough for hard RT, as you need to be able to
mathematically demonstrate that you can *never* miss a deadline.

Or are you saying that the latest developments in the stock kernel make
this possible?

Lee

