Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWAJON1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWAJON1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAJON1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:13:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34820 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932163AbWAJON0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:13:26 -0500
Date: Tue, 10 Jan 2006 15:13:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tim Tassonis <timtas@cubic.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Message-ID: <20060110141324.GJ3911@stusta.de>
References: <43C3AAE2.1090900@cubic.ch> <20060110125357.GH3911@stusta.de> <43C3B7C8.8000708@cubic.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3B7C8.8000708@cubic.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 02:34:00PM +0100, Tim Tassonis wrote:
> Adrian Bunk wrote:
> >On Tue, Jan 10, 2006 at 01:38:58PM +0100, Tim Tassonis wrote:
> >>...
> >>>We can always undo mistakes later, but 
> >>>we'll never get to that point if we don't start moving in one direction 
> >>>instead of ten.
> >>You were right if there were ten, but there seem to be only two at the 
> >>moment. One stack will survive and one will die. There's no point in 
> >>deciding this now.
> >
> >No, we'll end up with two stacks, some drivers using the first stack and 
> >some the second one.
> >
> >You can't simply let one stack die because this would imply either 
> >rewriting all drivers using this stack or dropping support for some 
> >hardware.
> 
> By "die", I didn't mean "delete it from kernel sources".
> 
> It is very probable that over time, the "winning" stack will contain 
> most drivers for the most common hardware, and the "losing" one just a 
> few obscure ones. The "losing" one will still be available for people 
> using hardware only supported by that stack.
> 
> Like the OSS/Alsa or XFree3.x/XFree4.x situations.

And OSS/ALSA is an example why this is not a good thing:
- OSS in the kernel is unmaintained
- people forced to use OSS drivers can't use applications only 
  supporting ALSA

In the OSS/ALSA case this was not avoidable since OSS was for a long 
time the sound system in the kernel, and ALSA came later.

But if you have the possibility to choose which stack to use at the 
beginning (as in the wireless case), the only reasonable solution is to 
choose _one_ stack.

> Tim

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

