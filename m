Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVHRJpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVHRJpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVHRJpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:45:38 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:29639 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932146AbVHRJpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:45:38 -0400
Message-ID: <43045A93.1080806@aitel.hist.no>
Date: Thu, 18 Aug 2005 11:53:23 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: Steven Rostedt <rostedt@goodmis.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [Fwd: Console locking and blanking]
References: <1124242875.8848.10.camel@gaston>	 <1124249381.8848.19.camel@gaston>	 <1124250271.5764.76.camel@localhost.localdomain> <1124250948.4855.93.camel@localhost.localdomain>
In-Reply-To: <1124250948.4855.93.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla Beeche wrote:

>On Tue, 2005-08-16 at 23:44 -0400, Steven Rostedt wrote:
>  
>
>>On Wed, 2005-08-17 at 13:29 +1000, Benjamin Herrenschmidt wrote:
>>    
>>
>>>On Wed, 2005-08-17 at 11:41 +1000, Benjamin Herrenschmidt wrote:
>>>
>>>      
>>>
>>>>(I'm blind and I use a braille display. I use those functions to blank 
>>>>my laptop's screen so people don't read it, and hopefully to conserve 
>>>>power.)
>>>>        
>>>>
>>At the OLS I learned that the backlight of a laptop (when the screen is
>>black, but still glows) actually spends more wattage than when the
>>screen is lit.  So, unless you actually turn the laptop display off,
>>switching it to black will actually burn the battery quicker.
>>    
>>
>
>This sounds stupid. Who told you this? The actual brightness is the one
>that consumes the most battery.
>  
>
The backlight itself consume the same power wether the pixels are
transparent (white) or opaque (black).  The pixels themselves consume
more power when black in some kinds of screens - regardless of what
the backlight is doing.

So a black screen may waste power - because the backlight is still on
behind those black pixels.  Such a screen also get marginally hotter,
because wasted light from the backlight gets absorbed in black
pixels, but radiated into the room through white pixels.


If you want to save power:
1. turn the backlight off, if possible.  If there is no other way,
    close the lid and use an external keyboard.  Or jam the lid switch with
    something.  A good laptop should definitely have a way to turn it 
off though,
    for example if the user leaves the machine alone for a long while with
    the lid up.

2. For privacy (and power saving) blank all the pixels to white instead of
    black - _if_ it is a tft display.  There are of course designs where 
the
    white pixels use more power (all cases where light is produced in the
    pixels themselves, instead of relying on backlight.)  So there is no
    universal solution.


Helge Hafting

