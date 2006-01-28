Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWA1UiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWA1UiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 15:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWA1UiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 15:38:20 -0500
Received: from www.ti-wmc.nl ([217.114.97.173]:12780 "EHLO budget014")
	by vger.kernel.org with ESMTP id S1750730AbWA1UiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 15:38:19 -0500
Message-ID: <39933.82.75.231.109.1138480680.squirrel@www.ti-wmc.nl>
In-Reply-To: <Pine.LNX.4.64.0601272333070.2909@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com>
    <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
    <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
    <43D7B20D.7040203@wolfmountaingroup.com>
    <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>
    <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
    <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
    <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
    <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
    <43D9F9F9.5060501@ti-wmc.nl>
    <Pine.LNX.4.64.0601272333070.2909@evo.osdl.org>
Date: Sat, 28 Jan 2006 21:38:00 +0100 (CET)
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
From: "Simon Oosthoek" <simon.oosthoek@ti-wmc.nl>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Simon Oosthoek" <simon.oosthoek@ti-wmc.nl>,
       "linux-os \\" <linux-os@analogic.com>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, "Marc Perkel" <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Patrick McLean" <pmclean@cs.ubishops.ca>,
       "Stephen Hemminger" <shemminger@osdl.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-Amavis-Scanned: by amavisd-new-2.3.2 (20050629) (Debian) at ti-wmc.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, January 28, 2006 5:39, Linus Torvalds said:
>
>
> On Fri, 27 Jan 2006, Simon Oosthoek wrote:
>>
>> I'm not sure this is the correct interpretation of the current draft. I
>> assume you're referring to this part:
>>
>> [ snipped ]
>
> Yes.
>
>> I'd interpret that as forcing people who try to hide their code or make
>> it difficult to get at the source code to not be able to do that.
>
> IF that is the legal interpretation, then yes, I'd agree with you. And no,
> I'm not a lawyer. However, the way I read it, it's not about just not
> being able to hide the object code - it's fundamentally about being able
> to replace and run the object code.

After some more reading and thinking, I agree with your interpretation.

> I may indeed be reading it wrong, but I don't think I am. It explicitly
> says "install and/or execute".
>
> So I think it says that if I have a private signing key that "enables" the
> kernel on some hardware of mine, GPLv3 requires that private key to be
> made available for that hardware. Note how that is tied to the _hardware_
> (or platform - usualyl the checking would be done by firmware, of course),
> not the actual source code of the program.
>
> And that's really what I don't like. I believe that a software license
> should cover the software it licenses, not how it is used or abused - even
> if you happen to disagree with certain types of abuse.
>
> I believe that hardware that limits what their users can do will die just
> becuase being user-unfriendly is not a way to do successful business. Yes,
> I'm a damned blue-eyed optimist, but I'd rather be blue-eyed than consider
> all uses of security technology to necessarily always be bad.
>

[snip: you don't like further restrictions on what people do with the
binaries]

I suppose this could be the achilles heel of the GPLv2, when a device
could be running perfectly free software, but the compiled work will only
run when signed with a private key of the manufacturer, this would create
a situation where the user/hacker cannot fix bugs on his own machine,
despite having full access to the source and in principle being able to
fix it. After installing the fixed software on the device it will stop
working.

Of course, a benevolent way of using this is to just check whether a
manufacturer supplied kernel is used for warranty reasons, but I suppose
some manufacturers will choose the simple option of not letting any other
software run on the device.

I suppose I'm not a blue eyed optimist (or brown eyed in my case), I can
see this being a real scenario :-(

Another way to fix this in GPLv3 would probably be to require the hardware
and firmware to allow the modified software to remain functional after
modification (barring newly introduced bugs).

Having said all this, GPLv2 is still a pretty good license, but it seems
there could be a real need for further reducing the likelyhood of (free)
software being locked up by DRM or (software) patents.

Cheers

Simon
