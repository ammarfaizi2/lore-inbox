Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTLUBti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTLUBti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:49:38 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:57220
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S261956AbTLUBtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:49:36 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Marc Schiffbauer <marc@schiffbauer.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031220193402.GA32297@lisa>
References: <1071864709.1044.172.camel@localhost>
	 <20031220193402.GA32297@lisa>
Content-Type: text/plain
Message-Id: <1071971341.1025.98.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 02:49:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 20:34, Marc Schiffbauer wrote:
> * Christian Meder schrieb am 19.12.03 um 21:11 Uhr:
> > Hi,
> > 
> > I've got a longstanding regression in gnomemeeting usage when switching
> > between 2.4 and 2.6 kernels.
> > 
> > Phenomenon: 
> > Without load gnomemeeting VOIP connections are fine. As soon as some
> > load like a kernel compile is put on the laptop the gnomemeeting audio
> > stream is cut to pieces and gets unintelligible . On 2.4.2x I don't get
> > even the slightest distortion in the audio stream under load. I played
> > around with different nice levels with no success. The problem persisted
> > during the whole 2.6.0-test series no matter whether I used -mm kernels
> > or pristine Linus kernels. Even when nicing the kernel compile to +19
> > the distortions start right away. I tried Nick Piggin's scheduler which
> > fared slightly better after changing the nice level of gnomemeeting to
> > -10 but it's still a far cry from the 2.4.2x feeling without any
> > fiddling with nice values.
> > 
> > Any hints where to start looking are greatly appreciated.
> > 
> 
> Hi Christian,
> 
> is it true, that your X-Server runs with a higher priority? Perhaps
> you are a Debian user?
> 
> If thats the case try to make your X-Server run with normal
> priority. That fixed sound problems here too. I had the problem that
> I could not play an mp3 file without distortion while compiling a
> kernel.

Oh I tried gnomemeeting, the Xserver and the kernel compile at different
nice levels without significant changes. Additionally I don't have any
problems with audio playback under load, it's just that gnomemeeting is
performing worse than in 2.4.2x.



			Christian

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




