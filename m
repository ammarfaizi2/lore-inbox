Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVI0PIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVI0PIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVI0PIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:08:42 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:54085 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964967AbVI0PIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:08:41 -0400
Date: Tue, 27 Sep 2005 11:08:17 -0400
From: Mathieu Chouquet-Stringer <ml2news@optonline.net>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: Re: Audigy2 renamed, grrr...
In-reply-to: <1127832555.1326.5.camel@mindpipe>
To: rlrevell@joe-job.com (Lee Revell)
Cc: linux-kernel@vger.kernel.org, Stl <stlman@poczta.fm>
Message-id: <m3achy4kgu.fsf@mcs.bigip.mine.nu>
Organization: Uh?
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <4338EF9A.1080906@poczta.fm> <1127832555.1326.5.camel@mindpipe>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rlrevell@joe-job.com (Lee Revell) writes:
> These changes were required to support the increasingly wide variety of
> emu10k1 based hardware.
> 
> Anyway it should not matter - newer versions of alsactl will still be
> able to restore the mixer settings.

Well it looks like I've lost my analog output in 2.6.14-rc2 (headphones on
the LiveDrive work fine though).

My card is now reported as a SBLive! Platinum 5.1 [SB0060] and i've been
loading the modules with the following:
extin=0x3fc3 extout=0x1fc3 enable_ir=1

It's been working fine until the latest git updates. I'll try
again tonight if I get the time.

-- 
Mathieu Chouquet-Stringer
