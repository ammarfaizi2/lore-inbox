Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVKQUqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVKQUqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVKQUqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:46:21 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50391 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964857AbVKQUqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:46:20 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Olivier Galibert <galibert@pobox.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051117203731.GG5772@redhat.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116220500.GF12505@elf.ucw.cz>
	 <20051117170202.GB10402@dspnet.fr.eu.org>
	 <1132257432.4438.8.camel@mindpipe>
	 <20051117201204.GA32376@dspnet.fr.eu.org>
	 <1132258855.4438.11.camel@mindpipe>  <20051117203731.GG5772@redhat.com>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 15:46:07 -0500
Message-Id: <1132260368.5959.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 15:37 -0500, Dave Jones wrote:
> I don't know about other distros, but here's how that usually goes for Fedora users..
> 
> 1. user installs new release, and sound doesn't work.
> 2. user blames ALSA, bug gets filed against kernel.
> 3. I take a look, sometimes we get to play "ping pong the bug between
>    userspace & kernel component" for a while
> 4. I throw my hands in the air and say "tell the upstream ALSA developers"
> 5. user does so
> 6. user comes back to Fedora bugzilla with the response
>    "Alsa people told me its a Fedora bug".
> 
> So, given we ship unpatched[1] ALSA, my faith in the
> possibility of ALSA working "OOTB" is somewhat lacking.
> 
> These bugs usually sit in our bugzilla, every so often
> I'll ping them after I've rebased to a new release, and
> surprise surprise, they magically get fixed.
> (Although every release we seem to trade one set of
>  working sound drivers for a new set of broken ones).

The process would work a lot faster if the Fedora project would
contribute anything at all to ALSA development.  It's a lot of work!  I
haven't seen a line of sound driver code from anyone at Red Hat since
the OSS->ALSA transition, years ago.  Meanwhile the vendors keep getting
cheaper and cheaper, which means more functionality that used to be in
hardware has to be done in the drivers.

For example the Debian people are very helpful, they have someone who
filters out the real bug reports from their users and pushes them into
the ALSA bug tracker.  Fedora just points clueless users at the ALSA bug
tracker and tells them "good luck".

Lee

