Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbUKVSQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbUKVSQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUKVSPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:15:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:22757 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262293AbUKVSOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:14:04 -0500
Subject: Re: [Alsa-devel] Re: [2.6 patch] ALSA PCI drivers: misc cleanups
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <s5hoehpvkdl.wl@alsa2.suse.de>
References: <20041121235855.GI13254@stusta.de>
	 <1101088632.5119.2.camel@krustophenia.net> <s5hsm71vlrc.wl@alsa2.suse.de>
	 <1101145386.2873.2.camel@krustophenia.net>  <s5hoehpvkdl.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 13:14:01 -0500
Message-Id: <1101147241.2873.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 18:55 +0100, Takashi Iwai wrote:
> > Nope.  Any idea what this is/was for?  I poked around the OSS driver and
> > could not find a similar function.
> 
> IIRC, it came from the very old version of OSS emu10k1 driver.
> 

OK.  If this code was in the original opensource.creative.com driver
then there is always the chance it embodies some knowledge of the
hardware that we don't have.  For example set_loop_stop, which was also
in the OSS driver but unused, can be used to start multiple channels in
sync.  But as long as the CVS history is available this should not be a
problem.

Lee

