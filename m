Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUATJq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUATJq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:46:57 -0500
Received: from www.tammen.de ([62.225.14.106]:20997 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id S265314AbUATJqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:46:32 -0500
From: Heinz Ulrich Stille <hus@design-d.de>
Organization: design_d gmbh
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA vs. OSS
Date: Tue, 20 Jan 2004 10:46:13 +0100
User-Agent: KMail/1.5.94
References: <1074532714.16759.4.camel@midux> <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org> <1074536486.5955.412.camel@castle.bigfiber.net>
In-Reply-To: <1074536486.5955.412.camel@castle.bigfiber.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200401201046.24172.hus@design-d.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 January 2004 19:21, Travis Morgan wrote:
> I have a soundblaster Live Value card. I can no longer control the

I also have a SB Live!, and it doesn't work with ALSA at all - the AC97
codec doesn't load. I haven't taken the time to track it down as it does
work just fine with OSS (under SMP at that).

> output level through my digital out. With OSS my PCM volume used to
> affect both the headphone jack and the digital out. With ALSA it affects
> only the headphone jack.

That's a purely firmware thing with this card; you should just have to
load the right patches. I don't know whether there is a loader utility
for alsa, though. Perhaps the old utils will work?

Anyway, even if it's not working for me at the moment, it's still the
superior architecture; just wait until the bugs affecting your specific
situation are ironed out and userland utilities are available...

MfG, Ulrich

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400463 / Fax: +49-541-9400450
design_d gmbh / Lortzingstr. 2 / 49074 Osnabrück / www.design-d.de
