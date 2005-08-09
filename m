Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVHIRtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVHIRtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVHIRtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:49:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9993 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932558AbVHIRtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:49:11 -0400
Date: Tue, 9 Aug 2005 19:49:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>, gregkh@suse.de,
       NAGANO Daisuke <breeze.nagano@nifty.ne.jp>, alan@lxorguk.ukuu.org.uk,
       sailer@ife.ee.ethz.ch
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zaitcev@yahoo.com,
       Christoph Eckert <ce@christeck.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal (version 2)
Message-ID: <20050809174906.GA4006@stusta.de>
References: <20050729153226.GE3563@stusta.de> <1123607633.5601.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123607633.5601.7.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 01:13:51PM -0400, Lee Revell wrote:
> On Fri, 2005-07-29 at 17:32 +0200, Adrian Bunk wrote:
> > This patch schedules obsolete OSS drivers (with ALSA drivers that 
> > support the same hardware) for removal.
> > 
> > Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
> > 
> 
> Someone on linux-audio-user just pointed out that the OSS USB audio and
> midi modules were never deprecated, much less scheduled to be removed.
> 
> Maybe the best way to deprecate them is to move them to Sound -> OSS,
> that's where they belong anyway.

I'd deprecate them without moving them.

I'll send a patch unless someone tells that any functionality of these 
drivers is lacking in ALSA.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

