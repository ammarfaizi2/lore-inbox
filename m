Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWGAOGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGAOGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWGAOGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:06:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49635 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751252AbWGAOGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:06:46 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Olivier Galibert <galibert@pobox.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, Olaf Hering <olh@suse.de>
In-Reply-To: <Pine.LNX.4.61.0607011048360.25773@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de>
	 <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org>
	 <1151702966.32444.57.camel@mindpipe>
	 <1151703286.11434.61.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0607011048360.25773@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 09:54:25 -0400
Message-Id: <1151762066.11897.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 10:54 +0200, Jan Engelhardt wrote:
> I cannot really use my onboard snd-intel8x0 because it lacks volume
> control on Master/PCM (= blows every headphone away), etc.
> 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
> AC'97 Sound Controller (rev a0)
> 

ALSA should provide a master volume, it's only the kernel OSS emulation
that cannot control the volume on such devices.  If ALSA does not give
you volume controls, please file a bug report.

Lee

