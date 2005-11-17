Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVKQUVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVKQUVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVKQUVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:21:05 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:46034 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964909AbVKQUVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:21:03 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051117201204.GA32376@dspnet.fr.eu.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116220500.GF12505@elf.ucw.cz>
	 <20051117170202.GB10402@dspnet.fr.eu.org>
	 <1132257432.4438.8.camel@mindpipe>
	 <20051117201204.GA32376@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 15:20:55 -0500
Message-Id: <1132258855.4438.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 21:12 +0100, Olivier Galibert wrote:
> On Thu, Nov 17, 2005 at 02:57:11PM -0500, Lee Revell wrote:
> > On Thu, 2005-11-17 at 18:02 +0100, Olivier Galibert wrote:
> > > On Wed, Nov 16, 2005 at 11:05:00PM +0100, Pavel Machek wrote:
> > > > Now... if something can be
> > > > done in userspace, it probably should.
> > > 
> > > And that usually means it just isn't done.  Cases in point:
> > > multichannel audio software mixing, video pixel formats conversion.
> > 
> > What are you talking about?  ALSA does mixing in userspace, it works
> > great.
> 
> You have an interesting definition of "great".
> 
> 1- It doesn't work without an annoyingly complex, extremely badly
>    documented user configuration. To the point that it doesn't work in
>    either an out-of-the-box, updated Fedora Core 3 nor an
>    out-of-the-box gentoo.
> 

File a bug report with your distro then.  This is supposed to work OOTB.

> 2- It doesn't work for programs that do not use the annoyingly complex
>    and horribly documented alsa library, which includes everything
>    that still uses OSS[1].
> 

There's plenty of ALSA documentation.  Anyway mixing for OSS apps does
work, they just have to use the aoss wrapper.

Lee

