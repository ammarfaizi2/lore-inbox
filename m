Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTDYJwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbTDYJwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:52:08 -0400
Received: from gate.perex.cz ([194.212.165.105]:41742 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S263542AbTDYJwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:52:07 -0400
Date: Fri, 25 Apr 2003 12:03:30 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Werner Almesberger <wa@almesberger.net>
Cc: Matthias Schniedermeyer <ms@citd.de>, Pat Suwalski <pat@suwalski.net>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
In-Reply-To: <20030424182227.P3557@almesberger.net>
Message-ID: <Pine.LNX.4.44.0304251202290.1347-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Werner Almesberger wrote:

> Jaroslav Kysela wrote:
> > We have emulation layer for non-ALSA mixers. This layer turns mute off 
> > automagically when volume is greater than zero.
> 
> Thanks for clarifying this ! So, would you agree with the following
> addition to Documentation/Changes ?
> 
>   ALSA (Advanced Linux Sound Architecture) is now the preferred
>   architecture for sound support, instead of the older OSS (Open
>   Sound System). Note that, in ALSA, all volume settings default
>   to zero, and all channels default to being "muted".
> 
>   User space therefore needs to explicitly increase the volume,
>   and "unmute" the respective audio channels before any sound
>   can be heard. 
> 
>   Mixers not explicitly supporting the "mute" functionality will
    ^^^^^^

I would change this to 'OSS mixers' because all ALSA mixers handle the 
mute feature.

>   usually "unmute" sources when setting the volume to a value
>   above zero.
> 
>   More information about ALSA, including configuration and OSS
>   compatibility, can be found in Documentation/sound/alsa/

It sounds good.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

