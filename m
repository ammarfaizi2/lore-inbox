Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTLTIcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 03:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTLTIcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 03:32:09 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:44771
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263843AbTLTIcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 03:32:07 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Christian Meder <chris@onestepahead.de>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Date: Sat, 20 Dec 2003 19:31:49 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
References: <1071864709.1044.172.camel@localhost> <3FE3D0CB.603@cyberone.com.au> <1071897314.1363.43.camel@localhost>
In-Reply-To: <1071897314.1363.43.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312201931.49831.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Dec 2003 16:15, Christian Meder wrote:
> I just tried hammering on the sound drivers on the playback side. So I
> put on a kernel compile, a find | cat >/dev/null and ogg123 playback.
> Playback performed largely unimpressed from the load level, no skips or
> whatever. Even adding a gnomemeeting connection didn't decrease audio
> playback.

Great, this is more the performance I'm used to hearing about.

> My guess is that the audio drivers are ok even more so because 
> otherwise OSS _and_ ALSA would be broken for my soundcard.
>
> That would leave me with two possibilities: 2.6. is doing something
> different in the gnomemeeting case or gnomemeeting is doing something
> different in the 2.6 case. A cursory look at the gnomemeeting sources
> didn't give me the impression that it's doing anything which would be
> affected by 2.6 deployment but I'll ask on the gnomemeeting-devel list
> for advice.

Threads perhaps?

Sounds more like a resource collision of some sort. IRQ conflict? Spurious 
interrupt? Were you facing Mecca when you ran it?

> Thanks for all your help, I hope I can nail it soon,

Good luck and keep us informed.

Con

