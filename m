Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWHPVLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWHPVLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWHPVLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:11:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47268 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932233AbWHPVLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:11:43 -0400
Subject: Re: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <44E37095.9070200@microgate.com>
References: <20060816104559.GF4325@ouaza.com>
	 <1155753868.3397.41.camel@mindpipe>  <44E37095.9070200@microgate.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 17:12:19 -0400
Message-Id: <1155762739.7338.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 14:23 -0500, Paul Fulghum wrote:
> Lee Revell wrote:
> > On Wed, 2006-08-16 at 12:45 +0200, Raphael Hertzog wrote:
> >>Now I switched to stock 2.6 and while the stock kernel improved in
> >>responsiveness, it still isn't enough by default (even with
> >>CONFIG_PREEMPT=y and CONFIG_HZ=1000). So I wanted to try the "rt" patch of
> >>Ingo Molnar and Thomas Gleixner, but the patched kernel doesn't boot (see
> >>bug report in a separate mail on this list).
> > 
> > 
> > Does the serial performance seem to have regressed from 2.4 to 2.6?  I
> > am chasing a similar issue with a serial MIDI card (supported by the bog
> > standard 8250 serial driver) that drops notes under 2.6 but works with
> > 2.4.  I don't have details yet, but it sounds like a similar problem.
> 
> What specific 2.6 kernels are each of you using?
> 

2.6.15 and 2.6.16.  Here is the .config:

http://members.dca.net/rlrevell/serialbug-config

I don't know which 2.4 version they tested on that worked - just that
the problem started when moving to 2.6.

Lee

