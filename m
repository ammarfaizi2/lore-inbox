Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVKQUMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVKQUMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVKQUMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:12:22 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:10770 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964895AbVKQUMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:12:21 -0500
Date: Thu, 17 Nov 2005 21:12:04 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117201204.GA32376@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost> <20051116220500.GF12505@elf.ucw.cz> <20051117170202.GB10402@dspnet.fr.eu.org> <1132257432.4438.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132257432.4438.8.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 02:57:11PM -0500, Lee Revell wrote:
> On Thu, 2005-11-17 at 18:02 +0100, Olivier Galibert wrote:
> > On Wed, Nov 16, 2005 at 11:05:00PM +0100, Pavel Machek wrote:
> > > Now... if something can be
> > > done in userspace, it probably should.
> > 
> > And that usually means it just isn't done.  Cases in point:
> > multichannel audio software mixing, video pixel formats conversion.
> 
> What are you talking about?  ALSA does mixing in userspace, it works
> great.

You have an interesting definition of "great".

1- It doesn't work without an annoyingly complex, extremely badly
   documented user configuration. To the point that it doesn't work in
   either an out-of-the-box, updated Fedora Core 3 nor an
   out-of-the-box gentoo.

2- It doesn't work for programs that do not use the annoyingly complex
   and horribly documented alsa library, which includes everything
   that still uses OSS[1].

You call that great?  Multiple audio streams is such a basic feature
it should work, period.  No if, no buts, and no obligatory library.
Which doesn't preclude having it in userspace, mind you.  But it
should never have been the _application_'s responsability.

  OG.

[1] Which is so easier to use for normal programs' audio it's not
    funny.
