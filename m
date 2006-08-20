Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWHTOnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWHTOnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 10:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWHTOnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 10:43:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7109 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750807AbWHTOnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 10:43:51 -0400
Subject: Re: mplayer + heavy io: why ionice doesn't help?
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Denis Vlasenko <vda.linux@googlemail.com>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, mplayer-users@mplayerhq.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608201021340.9707@yvahk01.tjqt.qr>
References: <200608181937.25295.vda.linux@googlemail.com>
	 <44E6006C.2030406@tremplin-utc.net>
	 <200608192004.10326.vda.linux@googlemail.com>
	 <Pine.LNX.4.61.0608201021340.9707@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 10:43:45 -0400
Message-Id: <1156085026.10565.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 10:22 +0200, Jan Engelhardt wrote:
> >
> >It helps. mplayer skips much less, but still some skipping is present.
> 
> Try with -ao alsa, then it should skip less, or at least, if it skip, skip 
> back so that less audio is lost.
> When playing audio-only files, it is always wise to specify e.g. -cache 320
> which proved to be a good value for my workloads.
> 

Only with the very latest versions of mplayer does ALSA work at all.
It's unusable here because it resets the auduio stream on each underrun
rather than simply ignoring them.

Lee

