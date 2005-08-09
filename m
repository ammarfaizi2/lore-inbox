Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVHIRPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVHIRPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVHIRPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:15:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29110 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964894AbVHIRPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:15:30 -0400
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal (version
	2)
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zaitcev@yahoo.com, Christoph Eckert <ce@christeck.de>
In-Reply-To: <20050729153226.GE3563@stusta.de>
References: <20050729153226.GE3563@stusta.de>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 13:13:51 -0400
Message-Id: <1123607633.5601.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-29 at 17:32 +0200, Adrian Bunk wrote:
> This patch schedules obsolete OSS drivers (with ALSA drivers that 
> support the same hardware) for removal.
> 
> Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
> 

Someone on linux-audio-user just pointed out that the OSS USB audio and
midi modules were never deprecated, much less scheduled to be removed.

Maybe the best way to deprecate them is to move them to Sound -> OSS,
that's where they belong anyway.

Lee

On Tue, 2005-08-09 at 18:42 +0200, Christoph Eckert wrote: 
> > Recompile the kernel with USB audio support.
> 
> Please ensure that you *disable* => Devioce drivers => USB => 
> USB audio and USB Midi.
> 
> Both are OSS modules and caused a lot of trouble here when 
> used in conjunction with the ALSA module
> 
> => Sound => ALSA => USB devices => USB Audio/MIDI driver
> 
> 
> BTW: OSS is marked as deprecated, but not the two OSS modules 
> mentioned above. Couldn't this get set or at least some info 
> that these modules belong to OSS?


