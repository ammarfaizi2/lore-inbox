Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313813AbSDPSd5>; Tue, 16 Apr 2002 14:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313814AbSDPSd4>; Tue, 16 Apr 2002 14:33:56 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:4371 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313813AbSDPSdz>;
	Tue, 16 Apr 2002 14:33:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 16 Apr 2002 20:33:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: MODULE_LICENSE string for LGPL drivers?
CC: linux-kernel@vger.kernel.org, jenglish@flightlab.com
X-mailer: Pegasus Mail v3.50
Message-ID: <28D84983F86@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Apr 02 at 19:31, Alan Cox wrote:
> > What should I use for the MODULE_LICENSE() string in a driver
> > that is distributed under the LGPL?  "LGPL" isn't listed in
> > include/linux/module.h as an "untainted" license, so should I
> 
> When LGPL code is linked with GPL code then the result becomes GPL. So
> once you have the code combined with the kernel it is GPL unless its
> a seperate work.

I do not want to be flammed, but source file itself is still LGPLed,
so stating "GPL" in source is at least misleading to users who will use 
same source under NT kernel. I think that modutils (if anyone) should know 
this metamorphose.

And license on the file itself definitely does not change by compilation,
as this would for example change glibc licensing to GPL just by anyone
linking his GPLed application statically with glibc.
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
