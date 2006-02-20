Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWBTAxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWBTAxD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWBTAxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:53:02 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20964 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751165AbWBTAxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:53:00 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060220004249.GJ15608@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe>
	 <200602192323.08169.s0348365@sms.ed.ac.uk>
	 <1140391929.2733.430.camel@mindpipe> <20060219234644.GD15608@elf.ucw.cz>
	 <1140393222.2733.438.camel@mindpipe> <20060220002628.GG15608@elf.ucw.cz>
	 <1140395432.2733.447.camel@mindpipe>  <20060220004249.GJ15608@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 19:52:57 -0500
Message-Id: <1140396778.2733.454.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 01:42 +0100, Pavel Machek wrote:
> On Ne 19-02-06 19:30:32, Lee Revell wrote:
> > On Mon, 2006-02-20 at 01:26 +0100, Pavel Machek wrote:
> > > ...but if I launch plain old aumix, I should be able to unmute it and
> > > use normally... and that is not the case :-(. 
> > 
> > Do you have a "libasound2"?
> 
> Yes:

> Source: alsa-lib
> Version: 1.0.10-2

Should be fine.  And the fact that OSS emulation is broken kind of rules
out the alsa-lib problem.

This does not sound like any problem we know about.  Are you sure the
hardware is still OK?  Do any of the channels work (try "speaker-test -D
surround51 --channels 6" while plugging your speakers into front, read,
center/lfe jacks).

Any chance of trying it in another machine?

Lee

