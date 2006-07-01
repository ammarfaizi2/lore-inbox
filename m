Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWGAIzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWGAIzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 04:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWGAIzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 04:55:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:60038 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932246AbWGAIzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 04:55:16 -0400
Date: Sat, 1 Jul 2006 10:54:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Lee Revell <rlrevell@joe-job.com>, Olivier Galibert <galibert@pobox.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
In-Reply-To: <1151703286.11434.61.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0607011048360.25773@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de>  <44A54D8E.3000002@superbug.co.uk>
 <20060630163114.GA12874@dspnet.fr.eu.org>  <1151702966.32444.57.camel@mindpipe>
 <1151703286.11434.61.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> As sound hardware gets dumber and cheaper, kernel OSS emulation will
>> become increasingly useless.  The cheap onboard devices (and even mid
>> range stuff like the SBLive! 24 bit) require sample rate conversion,
>> mixing, and even volume control to be handled in software.  ALSA's
>> in-kernel OSS emulation does not have these features and never will.
>> 

Brilliant. While in the graphics sector, cards and drivers always become fatter
and potentially less source-available than now, sound cards in contrast always
become thinner and more useless (while there is an open driver).
I cannot really use my onboard snd-intel8x0 because it lacks volume control on
Master/PCM (= blows every headphone away), etc.
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] AC'97
Sound Controller (rev a0)

>> (I wish the authors of Skype, Flash, TeamSpeak, Enemy Territory, and
>> other proprietary OSS-only apps would understand this ;-)
>
>maybe it's time to start printing a warning to users of OSS api (rate
>limited etc etc)

Not rate limited, so that it fulls up nicely, and admins see it sooner. If 
it just makes one message per hour or so, it may eventually be handled by 
the logrotate turnaround. Be faster than logrotate :)


Jan Engelhardt
-- 
