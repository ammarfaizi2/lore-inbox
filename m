Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVFUUmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVFUUmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVFUUji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:39:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52657 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262331AbVFUUhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:37:47 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050621133236.7c98d5d8.akpm@osdl.org>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <1119369028.19357.28.camel@mindpipe>
	 <20050621133236.7c98d5d8.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 16:37:40 -0400
Message-Id: <1119386260.4569.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 13:32 -0700, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Mon, 2005-06-20 at 23:54 -0700, Andrew Morton wrote:
> > > CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ
> > > Kconfigurable.
> > > 
> > >     Will merge (will switch default to 1000 Hz later if that seems
> > > necessary) 
> > 
> > Are you serious?  You're changing the *default* HZ in a stable kernel
> > series?!?
> > 
> > This is a big regression, it degrades the resolution of system calls.
> > 
> 
> Well we'll see what happens.  As I said, if it's determined to be a real
> problem we'll put the default back to 1000Hz prior to 2.6.13 release.
> 

I just think it's silly to merge CONFIG_HZ this late in the game, when
dynamic tick and high res timers are right around the corner.  Seems
like more trouble than it's worth.

Lee

