Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267004AbUBMRyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267034AbUBMRyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:54:25 -0500
Received: from pop.gmx.net ([213.165.64.20]:13189 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267004AbUBMRyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:54:22 -0500
X-Authenticated: #420190
Message-ID: <402D0F9F.70302@gmx.net>
Date: Fri, 13 Feb 2004 18:55:43 +0100
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: ps/2 mouse problem with KVM switch
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAIH4lUMJJWUqlFPWIv65Y6gEAAAAA@casabyte.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAIH4lUMJJWUqlFPWIv65Y6gEAAAAA@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> Note that the KVM Switch (typically) implements an intermediate "device" for
> the mouse so that when you are switched away to the other machine, the first
> machine is still "talking to something".
> 
> This has the less-than-desireable effect of causing the mouse device "inside
> the switch" to act as a largest-common-denominator.  Consequently many of
> the special features and peculiarities of your real device may not be
> accessible to your computer.

Well, under 2.4 they all work, probably because the settings for both 
systems are the same.

> A particular, and bette-documented, example of this can probably be found by
> trying to hook up a "new-fangled" keyboard (with the media control key
> cluster across the top and such) to your windows box.  When the keyboard
> drivers cannot find the special buttons and you call the KVM switch vendor
> they will promptly tell you about how all those hot extra buttons are not
> supported with their product, have a nice day, good-bye... 8-)

I have a Microsoft internet keyboard and the keys all work. I guess MS 
is big enough to be supported. (not that I use any of the keys). I 
haven't tried others.

> The same things go four your mouse, but are not as well documented and
> accessible to the KFM help desk weasels.
> 
> You should find that if you select a "much more generic" mouse configuration
> "everything works fine".

Yes, "bare" works. But I want my wheel to work.

> Some newer windows drivers "look past" the switch and activate the mouse
> features anyway.
> 
> Regardless, if your "other" computer is initializing the mouse through
> voodoo and dark magic to increase the reporting (baud?) rate and such, when
> you toggle to the Linux box you will see all sorts of unhappiness.  The
> inverse is also true, if the windows driver is expecting
> fast-and-feature-full and the side trip to Linux has set things back to
> mundane, the return to Windows will be "exciting"

I can see this would be a problem. I just haven't figured out the right 
rate, ... settings yet.
> 
> (My optimal configuration that saves heartache)
> 
> 2-Port plasma flat panel
>   DVI port connected to my primary use machine
>   VGA port connected to my KVM

I plan to to that when I upgrade my monitor. My current one doesn't have 
2 inputs. I'd still prefer one mouse and keyboard.


Regards,
Mark


