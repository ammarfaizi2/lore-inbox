Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVC1AbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVC1AbP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 19:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVC1AbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 19:31:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:10185 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261642AbVC1A2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 19:28:48 -0500
Subject: Re: Problems on Apple iBook with ALSA and snd-powermac [2.6.11.5]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: Jaroslav Kysela <perex@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050327230835.GA9006@minerva.local.lan>
References: <20050327230835.GA9006@minerva.local.lan>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 10:27:43 +1000
Message-Id: <1111969664.5409.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 01:08 +0200, Martin Loschwitz wrote:
> Hi folks,
> 
> given that the alsa-user-mailinglist has some strange kind of authentication
> mechanism, and admin-authorization and whatever, I'm writing this mail to the
> LKML (it would have been CCed here anyway).
> 
> The current snd-powermac module from ALSA seems to have trouble with modern
> Apple iBook computers (and possible other Apple notebooks, but I can't tell
> for sure). With 2.6.11.5 and having snd-powermac loaded, playing some sound
> results in a very noisy playback; you can only hear that if you turn volume
> on the PCM and VOL mixers up to the maximum, and even then, it's very hard 
> to hear. After removing snd-powermac and loading the "old" pmac-driver, the
> sound playback works just fine.

Have you tried disabling DRC Or increasing the DRC range level ?

> I have been able to find out that with 2.6.8 (at least with the version that
> Debian ships currently), the problem does not appear; snd-powermac does its
> job very nicely there. Given that 2.6.11 included some ALSA changes, I just
> compiled 2.6.10 on this box and booted it, and had the same problems I have
> with snd-powermac on 2.6.11.5.
> 
> Is this a known problem and is a fix available for it? If not, what can I do
> to help with hunting this bug? I really like ALSA and prefer it over the old
> pmac-sound-driver.
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

