Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbULOIcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbULOIcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbULOIcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:32:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22744 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261738AbULOIca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:32:30 -0500
Date: Wed, 15 Dec 2004 09:32:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <41BF7966.20009@nortelnetworks.com>
Message-ID: <Pine.LNX.4.61.0412150930410.11480@yvahk01.tjqt.qr>
References: <20041211142317.GF16322@dualathlon.random>  <20041212163547.GB6286@elf.ucw.cz>
  <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> 
 <Pine.LNX.4.61.0412130928350.2394@yvahk01.tjqt.qr> <1103064879.14699.75.camel@krustophenia.net>
 <41BF7966.20009@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ugh, because mplayer stupidly does disk i/o and AV playback and GUI in
>> the same thread.  Insert Xine plug.

There has been a real flame war on using threads in mplayer -- it ended in 
a fork into mplayer-xp. Surprisingly, the problem is not mplayer. Using the 
OSS kernel modules instead of ALSA, audio may drop, but it does not _skip_ it.

> This is not a problem as long as all of them can be done totally async.  As
> soon as anything blocks, then there's an issue.

Is there a way i can prioritize mplayer to get disk i/o done first?



Jan Engelhardt
-- 
ENOSPC
