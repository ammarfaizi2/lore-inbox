Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbTH3SkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 14:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTH3SkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 14:40:15 -0400
Received: from [66.241.84.54] ([66.241.84.54]:21888 "EHLO bigred.russwhit.org")
	by vger.kernel.org with ESMTP id S261987AbTH3SkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 14:40:11 -0400
Date: Sat, 30 Aug 2003 11:33:57 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: module char_10_135
In-Reply-To: <20030830100823.GM7038@fs.tum.de>
Message-ID: <Pine.LNX.4.53.0308301123170.468@bigred.russwhit.org>
References: <Pine.LNX.4.53.0308201736040.178@bigred.russwhit.org>
 <20030830100823.GM7038@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Aug 2003, Adrian Bunk wrote:

> On Wed, Aug 20, 2003 at 05:54:15PM -0700, Russell Whitaker wrote:
> >
> > During boot-up, and just after the setting the clock line, noticed the
> > following line:
> >
> > modeprobe: FATAL: module char_10_135 not found
> >
> > First noticed this a few revisions ago. The contents of directory
> > /lib/modules/2.6.0-test3-bk8/kernel/drivers/char:
> >
> > agp/  genrtc.ko  hw_random.ko  lp.ko  rtc.ko
> >
> > hmm, long shot, but perhaps this bug is related to not auto-loading
> > module lp?
>
> Minor 135 is rtc.
>
> Do you have module-init-tools installed?
>
module-init-tools 0.9.13-pre 2

That was the latest version I could find on Aug 3rd. Please let me know
if there is a later version I should try.

Thanks,
  Russ
