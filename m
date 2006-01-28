Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWA1Ejy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWA1Ejy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWA1Ejy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:39:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751399AbWA1Ejx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:39:53 -0500
Date: Fri, 27 Jan 2006 23:39:25 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
cc: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43D9F9F9.5060501@ti-wmc.nl>
Message-ID: <Pine.LNX.4.64.0601272333070.2909@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jan 2006, Simon Oosthoek wrote:
> 
> I'm not sure this is the correct interpretation of the current draft. I
> assume you're referring to this part:
>
> [ snipped ]

Yes.

> I'd interpret that as forcing people who try to hide their code or make it
> difficult to get at the source code to not be able to do that.

IF that is the legal interpretation, then yes, I'd agree with you. And no, 
I'm not a lawyer. However, the way I read it, it's not about just not 
being able to hide the object code - it's fundamentally about being able 
to replace and run the object code.

I may indeed be reading it wrong, but I don't think I am. It explicitly 
says "install and/or execute".

So I think it says that if I have a private signing key that "enables" the 
kernel on some hardware of mine, GPLv3 requires that private key to be 
made available for that hardware. Note how that is tied to the _hardware_ 
(or platform - usualyl the checking would be done by firmware, of course), 
not the actual source code of the program.

And that's really what I don't like. I believe that a software license 
should cover the software it licenses, not how it is used or abused - even 
if you happen to disagree with certain types of abuse.

I believe that hardware that limits what their users can do will die just 
becuase being user-unfriendly is not a way to do successful business. Yes, 
I'm a damned blue-eyed optimist, but I'd rather be blue-eyed than consider 
all uses of security technology to necessarily always be bad.

		Linus
