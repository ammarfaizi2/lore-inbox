Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbUKTT1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUKTT1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUKTT1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:27:33 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18833 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263165AbUKTT10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:27:26 -0500
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: John Mock <kd6pag@qsl.net>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <20041120185100.GA1205@elf.ucw.cz>
References: <E1CVYZM-0000Fi-00@penngrove.fdns.net>
	 <20041120185100.GA1205@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 14:11:42 -0500
Message-Id: <1100977903.6879.56.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: alsa-devel on ALSA issues (we now allow posts from non
subscribers! :-P).

On Sat, 2004-11-20 at 19:51 +0100, Pavel Machek wrote:
> Hi!
> 
> > The software suspend issue was long and tedious to narrow down.  Yep, as
> > you suspected, it appears to be specific a driver (or group thereof).  It
> > appears to happen when the sound subsystem is included.  Attached below 
> > is the .config and a 'diff' from the losing one to one which works.
> 
> Okay, this is for the alsa team then. Somewhere between 2.6.10-rc1 and
> 2.6.10-rc2, ALSA started breaking swsusp :-(.
> 								Pavel
> 
-- 
Lee Revell <rlrevell@joe-job.com>

