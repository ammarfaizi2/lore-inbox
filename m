Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVC2S4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVC2S4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVC2S4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:56:48 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61446 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261295AbVC2S4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:56:46 -0500
Date: Tue, 29 Mar 2005 20:58:25 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
Message-ID: <20050329185825.GB20973@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <2a0fbc59050325145935a05521@mail.gmail.com> <1111792462.23430.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111792462.23430.25.camel@mindpipe>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 06:14:22PM -0500, Lee Revell wrote:
> On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > - audio works too. The only problem is that two applications can't
> > open /dev/dsp in the same time.
> 
> Not a problem.  ALSA does software mixing for chipsets that can't do it
> in hardware.  Google for dmix.
> 
> However this doesn't (and can't be made to) work with the in-kernel OSS
> emulation (it works fine with the alsa-lib/libaoss emulation).  So you

 quake3 still segfaults when run through "aoss". And can't be fixed, as
it's closed source still.

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray

