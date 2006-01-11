Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWAKJSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWAKJSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWAKJSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:18:46 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:4809 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751389AbWAKJSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:18:45 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Wed, 11 Jan 2006 10:18:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/10] NTP: Remove pps support
Cc: linux-kernel@vger.kernel.org
Message-ID: <43C4DB67.24764.AB21FFF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1136935211.2890.11.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.61.0512220019330.30882@scrub.home>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=114204@20060111.090731Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

accidentially ;-) I did merge my PPSkit-light into SuSE's 2.6.13 tree. It wasn't a 
big issue to merge the patch, but that might not be sufficient. Originally I 
wanted to update the patch for a standard kernel tree, but I realized that I first 
have to get the sources. I cannot promise you when, but I'll try to apply my stuff 
to a recent 2.6 kernel.

So if there's a kernel source to merge my stuff with, tell me wich, but the source 
should be stable enough to give me time to finish the merge before the next one is 
out. I only have a slower modem at home, so I cannot refresh sources frequently.

Does a release candidate kernel have the nanosecond clock in now? I got that 
impression recently.

BTW: Leaving the old crap in the kernel would help me to merge my stuff (Looking 
for "anchors" in the sources).

Regards,
Ulrich

On 10 Jan 2006 at 15:20, john stultz wrote:

> On Thu, 2005-12-22 at 00:20 +0100, Roman Zippel wrote:
> > This removes the support for pps. It's completely unused within the
> > kernel and is basically in the way for further cleanups. It should be
> > easier to readd proper support for it after the rest has been converted
> > to NTP4.
> > Patch is originally done by John Stultz, I did some minor cleanups and
> > updated it.
> > 
> > Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> Hey Roman, sorry for the slow response, but I've been busy since getting
> back from the holiday.
> 
> Initially when I wrote this I was hoping to prod Ulrich into updating
> and sending his PPS driver for inclusion. But I believe he has just been
> too busy, so pulling this code is probably the right thing. 
> 
> Acked-by: John Stultz <johnstul@us.ibm.com>
> 
> 
> I do hope someone interested in PPS drivers will re-add the support code
> along with a driver that utilizes the interface at some point.
> 
> thanks
> -john
> 


