Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUH0Nlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUH0Nlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 09:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUH0Nlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 09:41:50 -0400
Received: from [195.23.16.24] ([195.23.16.24]:45226 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263818AbUH0Nln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 09:41:43 -0400
Message-ID: <412F3A12.70709@grupopie.com>
Date: Fri, 27 Aug 2004 14:41:38 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wouter Van Hemel <wouter-kernel@fort-knox.rave.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
References: <33193.151.37.215.244.1093530681.squirrel@webmail.azzurra.org> <Pine.LNX.4.61.0408261948480.555@senta.theria.org> <200408270845.38015.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.61.0408271439040.578@senta.theria.org>
In-Reply-To: <Pine.LNX.4.61.0408271439040.578@senta.theria.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.35; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouter Van Hemel wrote:
> On Fri, 27 Aug 2004, Denis Vlasenko wrote:
> 
>> If you feel like it, you can even step up and maintain it.
>>
> 
> I really would, if it wouldn't be C, kernel makefile stuff_and_ driver 
> specifics. My current knowledge wouldn't do the driver justice, to say 
> it mildly.
> 
> Perhaps one of the maintainers of other webcam drivers could help out here.
> 
>>> Maybe Philips will open up their oh so secret compression algorithm 
>>> if we
>>> all ask them nicely. I mean, how secret can that still be?...
>>
>>
>> Corporations can be ridiculous/bureaucratic at times. Especially large 
>> ones.
>>
> 
> True, but I still think Philips was on the right track. I doubt that 
> their driver being pulled will aid linux support for their products...

I was really trying to restrain myself from entering this thread, but I 
can't help it anymore...

What do Phillips gain from making their compression code secret? (If it 
is really secret... I probably can reverse engineer it legally for the 
purpose of interoperability)

They are basically saying: "Yes the quality of our webcam is as bad as 
the competition, with the same low-quality cmos sensors, plastic lenses, 
high noise analog conditioning, etc. *but* we are so much better than 
our competitors because we have a secret compression algorithm that we 
don't want them to know because they can never figure out how to do a 
compression algorithm on their own..."

No, Phillips was *not* on the right track.

Hardware products should gain with _hardware_ merits. If the Phillips 
camera has a better lens, that allows more light in under ambient light, 
or some such, it is better than the competition.

The right track would be to provide all the hardware info so that a real 
open source driver could be written. (or even better, provide the open 
source driver themselves)

About the legal aspects of all this, they have been discussed 
extensively in the past. It is not about "hey this is just a simple 
hook", it is all about the derived work concept. This driver does 
absolutely nothing outside the kernel. It's only purpose is to attach 
itself to the kernel and to provide the images from the camera to 
userspace using the kernel ABI's. So you can not say it is not a derived 
work at all.

I for one, would really like to see Phillips allow Nemosoft to build a 
really open source driver, and not let all the work go to waste...

-- 
Paulo Marques - www.grupopie.com
