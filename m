Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWAQUiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWAQUiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWAQUiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:38:06 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:4839 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S964826AbWAQUiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:38:05 -0500
Date: Tue, 17 Jan 2006 15:38:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.16-rc1
In-reply-to: <1137521136.6446.40.camel@localhost>
To: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Reply-to: gene.heskett@verizon.net
Message-id: <200601171538.03656.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
 <200601171125.40854.gene.heskett@verizon.net>
 <1137521136.6446.40.camel@localhost>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 13:05, Mauro Carvalho Chehab wrote:
>Gene,
>
> Please address these questions to V4L Mailing list, since it is the
>better forum for this kind of discussions.

Well, I may have barked prematurely about the audio quality.  I found 
that turning off the max boost in the gain settings in the tvtime 
menu's got it back within the cards headroom and the audio from tvtime 
is just fine now.  My remaining concern is that the onscreen volume 
control in tvtime has disconnected itself from reality, doing nothing 
to any slider in the kamix screen, or to the audio level.  My version 
of kmix is too old to see this Audigy 2 card correctly, so I had to 
switch to kamix.  That may be the same situation with tvtime, which 
otherwise Just Works(TM) here.

>Em Ter, 2006-01-17 às 11:25 -0500, Gene Heskett escreveu:
>> On Tuesday 17 January 2006 03:19, Linus Torvalds wrote:
>> >Ok, it's two weeks since 2.6.15, and the merge window is closed.
>>
>> Well, I sorta broke my never build an -rc1 rule.
>>
>> It seems to be stable so far, but I have a cx88 based video card, a
>> pcHDTV-3000, and there's 2 problems with the audio.  That dma
>> function was turned off in the .config as the lspci -n didn't report
>> the right numbers.
>
> To enable cx88-alsa, you need to have alsa enabled at kernel.
>
> Not all devices supports digital audio on cx2388x. There's a bit at
>board's eeprom specifying if digital audio is provided by the board.
> If this bit is set, you will see 1741:8801 or 1741:8811 with lspci
> -n. If your device doesn't show these numbers, the module will not
> work.
>
>> 1. tvtimes volume control has no effect, in kamix, its now the
>> 'front' slider.  Its actually plugged into the line in jack of a
>> SBLive Audigy 2 Value card.
>
>	This is not a kernel question. Anyway, tvtime config file have a
> field specifying which input line is selected.
>
>> 2. The audio has a definite 'dragging voice coil' sound, very
>> tiresome to listen to, highly clipped regardless of the gain
>> settings.
>
>	We need more info about this, like video and audio standard, audio
> mode (mono, stereo, sap), what device, dmesg. Please provide these
> info to v4l ml and we will be happy to help you.
>
>> Since I do watch tv on this box, I'll go back to 2.6.15.1 until -rc2
>> is released.
>
>Cheers,
>Mauro.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
