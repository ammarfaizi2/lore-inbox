Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290257AbSAOT37>; Tue, 15 Jan 2002 14:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290260AbSAOT3u>; Tue, 15 Jan 2002 14:29:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22938 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290257AbSAOT3g>; Tue, 15 Jan 2002 14:29:36 -0500
Message-ID: <3C4482A2.8040903@us.ibm.com>
Date: Tue, 15 Jan 2002 11:27:30 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020114
X-Accept-Language: en-us
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] cs46xx: sound distortion after hours of use
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua> <20020115152000.GD13196@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:

>On Tue, Jan 15, 2002 at 02:24:00PM -0200, Denis Vlasenko wrote:
>
>>I have noticed that after hours of palying mp3s thru my onboard audio
>>(I use cs46xx module) sound becomes distorted (high-pitch noise).
>>
>>Restarting xmms does not help.
>>
>>rmmod cs46xx; modprobe cs46xx fixes it.
>>
>Are you running a battery monitor or something similar? In that case it
>can cause the CPU to go into SMM with interrupts disabled to talk to
>the batteries and completely forget about servicing the audio IRQ
>thereby fscking up the sound. I had the same problems on my laptop and
>killing gnome_battery_applet fixed it.
>
I have the same problem, but very rarely.  I, too, use the 
rmmod/modprobe technique to fix it.  Have either of you found a way to 
excite the problem without waiting hours for it to happen?

--
Dave Hansen
haveblue@us.ibm.com

