Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318414AbSGSBB4>; Thu, 18 Jul 2002 21:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318415AbSGSBB4>; Thu, 18 Jul 2002 21:01:56 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:46341 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S318414AbSGSBBz> convert rfc822-to-8bit; Thu, 18 Jul 2002 21:01:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Tyan s2466 stability
Date: Thu, 18 Jul 2002 20:04:51 -0500
User-Agent: KMail/1.4.2
References: <Pine.LNX.4.44.0207181712050.2065-100000@betelgeuse.compendium-tech.com>
In-Reply-To: <Pine.LNX.4.44.0207181712050.2065-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207182004.51402.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 07:27 pm, Kelsey Hudson wrote:
> according to the amd760mpx datasheet, stuff on the 32/33MHz
> bus isn't allowed to busmaster while the 64/66MHz bus is
> operating at 66MHz. so that means the 66MHz bus needs to be
> throttled to 33MHz either via a 3.3V 33MHz card stuck in it,
> or that pretty blue jumper stuffed on the appropriate FORCE
> 33MHz header on the board.

VERY nice info, thanx. ;)

I'll have to save this info for myself; I've always been planning 
to get a dual Athlon setup sooner or later.

> these kind of problems will cause things like loss of
> streaming due to the inability to busmaster. both of my dual
> athlon systems here at cti have that jumper shorted. sure, i
> still run into problems, but then again, what chipset for amd
> processors doesn't have a whole load of issues? overall, i
> can't say i'm satisfied with any athlon chipset on the market
> right now. but, the 760mpx has far fewer issues than, say, any
> garden variety via board. (no comments from the peanut gallery
> -- my mind is made up and in this respect, your opinion means
> nothing to me. via sucks. end of story). but, i digress.

Yes, VIA sucks.  I've been lucky so far (all my VIA chipsets can 
be shoe-horned to stability), but it hasn't always been easy.

> aside from these rather annoying pci quirks and a sensors
> issue (who in their right mind assigns the same i2c address
> for two different chips?!) the board works quite well in the
> configuration i've got it in (beowulf cluster).
>
> oh and all the devices on this board are fully acpi
> controlled. let it be known that i hate acpi, and especially
> the headaches that it causes me. the stock bios also sucks
> quite vigorously and should be avoided at all costs (read:
> upgrade to the latest bios rev immediately).
>
> if you need help integrating one of these boards into your
> system i may be able to provide some insight.

Is this motherboard using the Phoenix, AMI, or Award BIOS?  Award 
is nice and simple and solid; AMI is ok, but often goes too much 
for pretty looks; Phoenix SUCKS in every way possible.

What other issues have you encountered with this board (and other 
760MP/MPX boards)?  So far I've heard of an issue with 3com 
Gigabit cards on some specific model of Tyan 760MP/MPX board, 
but no definite details.  I've also heard of lm_sensors people 
having a fair amount of trouble with it.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

