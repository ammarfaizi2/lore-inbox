Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbTA3RRW>; Thu, 30 Jan 2003 12:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTA3RRW>; Thu, 30 Jan 2003 12:17:22 -0500
Received: from 12-240-9-4.client.attbi.com ([12.240.9.4]:18048 "EHLO
	pinkie.homelinux.net") by vger.kernel.org with ESMTP
	id <S267558AbTA3RRU>; Thu, 30 Jan 2003 12:17:20 -0500
Message-ID: <3E396032.2000503@lbl.gov>
Date: Thu, 30 Jan 2003 09:26:10 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>	 <3E384D41.9080605@lbl.gov>	 <1043926998.28133.21.camel@irongate.swansea.linux.org.uk>	 <3E395C30.6040903@lbl.gov> <1043950661.31674.12.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1043950661.31674.12.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2003-01-30 at 17:09, Thomas Davis wrote:
> 
>>>FM801 is a card not a codec
>>>
>>
>>Sorry, this then adds to the ac97 codec list the fm801, which has a ac97 
>>codec on it, and takes it from being "unknown" to "known".
>>
>>The forte driver uses the ac97codec code; with this, ac97_probe_codec 
>>registers it correctly as Forte Media, and not unknown.
> 
> 
> FM801 is still the card not the codec. Somewhere on the FM801 is a 48pin AC97 codec,
> it may even vary by card version, much like I have intel i810 audio with a variety
> of codec devices.
> 

Yes, I agree on that..  I'm just trying to get the name "Forte Media 
FM801" instead of "Unknown" to show up in the ac97 list.

thomas

