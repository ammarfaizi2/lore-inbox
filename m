Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311919AbSCTIfo>; Wed, 20 Mar 2002 03:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311921AbSCTIfe>; Wed, 20 Mar 2002 03:35:34 -0500
Received: from gate.perex.cz ([194.212.165.105]:58888 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S311919AbSCTIf2>;
	Wed, 20 Mar 2002 03:35:28 -0500
Date: Wed, 20 Mar 2002 09:30:51 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: J Sloan <jjs@lexus.com>
cc: "Wayne.Brown@altec.com" <Wayne.Brown@altec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7 make modules_install error (oss)
In-Reply-To: <3C97889B.6060301@lexus.com>
Message-ID: <Pine.LNX.4.33.0203200923380.715-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, J Sloan wrote:

> Agreed, the oss drivers should _at least_
> be maintained as an alternative, e.g. for
> those of us who want reliable sound with
> *low latency*
> 
> <explanation>
> I haven't checked lately, but not too long
> ago the alsa drivers were found to be one
> of the worst sources of latency in the kernel.
> </explanation>

You should really take care about your words. You've not written any
technical reason to say these sentences. We are not aware about any
problems against low-latency. Sure, OSS API emulation is only emulation,
so there is additional layer which can be a bit slower than simplified
native OSS drivers, but using ALSA API, we get really serious latencies
even for multichannel hardware.

I propose to join to our efford and fix (or at least - point to) problems 
(if any) in ALSA drivers. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

