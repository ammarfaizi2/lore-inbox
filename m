Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316613AbSEUV2P>; Tue, 21 May 2002 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316622AbSEUV2P>; Tue, 21 May 2002 17:28:15 -0400
Received: from [195.39.17.254] ([195.39.17.254]:14490 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316613AbSEUV2N>;
	Tue, 21 May 2002 17:28:13 -0400
Date: Tue, 21 May 2002 23:24:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: driverfs problems
Message-ID: <20020521212449.GA3050@elf.ucw.cz>
In-Reply-To: <200205171408.g4HE8tK65272@d12relay02.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a.t.m. three different ideas for how to structure the driverfs, in 
> this case:
> a) flat listing:
> /root/channel/{0000,0100,0103,0102,1000-13ff}
> advantage: reflects the real physical layout, no policy
> disadvantage: difficult to parse as a human (similar to pre-devfs /dev/*),
> possible scalability problems when scanning through long lists in
> kernel

I'd prefer this. 65000 is not that much, and anything else is ugly...
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
