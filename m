Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVCDAoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVCDAoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVCDAlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:41:05 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:48258 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262563AbVCDAgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:36:24 -0500
Message-ID: <4227AD81.9000606@drzeus.cx>
Date: Fri, 04 Mar 2005 01:36:17 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nish Aravamudan <nish.aravamudan@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net,
       Mark Canter <marcus@vfxcomputing.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: intel 8x0 went silent in 2.6.11
References: <4227085C.7060104@drzeus.cx> <29495f1d05030309455a990c5b@mail.gmail.com>
In-Reply-To: <29495f1d05030309455a990c5b@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan wrote:

>On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>  
>
>>I just upgraded to Linux 2.6.11 and the soundcard on my machine went
>>silent. All volume controls are correct and there are no errors
>>reported. But no sound coming from the speakers. And here's the kicker,
>>the headphones work fine!
>>2.6.10 still works so the bug appeared in one of the patches in between.
>>The sound card is the one integrated into intels mobile ICH4 chipset.
>>    
>>
>
>There was some discussion of this on LKML a while ago. Are you sure
>you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
>alsamixer?
>
>Thanks,
>Nish
>  
>
This has been rather wildly debated now but yes, muting those enables 
sound. I don't have a docking station so I can't try any effects there.
I wouldn't say that it's intuitive to mute two channels to get speakers 
working though.

Rgds
Pierre

