Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVCIAJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVCIAJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCIAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:06:31 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37257 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262427AbVCHXuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:50:52 -0500
Subject: Re: RFD: Kernel release numbering
From: Lee Revell <rlrevell@joe-job.com>
To: szonyi calin <caszonyi@yahoo.com>
Cc: Dave Jones <davej@redhat.com>, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050308232552.97747.qmail@web52907.mail.yahoo.com>
References: <20050308232552.97747.qmail@web52907.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 18:50:51 -0500
Message-Id: <1110325851.6510.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 00:25 +0100, szonyi calin wrote:
> I reported once a bug on alsa-devel and cc-ed on lkml 
> The sequencer isn't working with my card cs4239 with alsa.
> 

What exactly do you mean by "it isn't working"?

90% of "MIDI does not work" bug reports are from users who expect
playing MIDI files to work OOTB like it does on Mac and Windows.

This only works because those OS'es come bundled with a toy softsynth.
With ALSA, you either need a supported hardware wavetable synth
(emu10k1) or a real soft synth like Timidity or Fluidsynth.

Anyway, please repost your bug report to alsa-devel.  There is no point
in cc'ing LKML for ALSA problems, unless you find a problem like a
regression in ALSA functionality from one kernel release to another.

Lee

