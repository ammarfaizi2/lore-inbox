Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTFSXtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTFSXtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:49:51 -0400
Received: from [81.193.96.95] ([81.193.96.95]:30947 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S261985AbTFSXtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:49:46 -0400
Message-ID: <3EF24F1A.1040009@vgertech.com>
Date: Fri, 20 Jun 2003 01:02:34 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Samphan Raruenrom <samphan@thai.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Crusoe's persistent translation on linux?
References: <3EF1E6CD.4040800@thai.com> <20030619200308.A2135@ucw.cz> <3EF2144D.5060902@thai.com>
In-Reply-To: <3EF2144D.5060902@thai.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Samphan Raruenrom wrote:
> Vojtech Pavlik wrote:
> 
>>> I'm using 2.4.21 kernel on TM5800 Crusoe in Compaq TC1000 Tablet PC.
>>> Currently the performance is not very good but the more I learn
>>> about its architecture the more I'm obessesed about it (just like
>>> the days when I use 68000 Amiga). Too bad that there are very little
>>> information about the chip so I can't do anything much to improve
>>> the performance myself (like enlarge the translation cache? how?).
>>
>> How much 'not very good' is the performance? I'm considering buying an
>> Sharp Actius MM10 notebook, and so far I wasn't able to find ANY numbers
>> on how fast a 1GHz Crusoe actually is, nevermind with Linux running on
>> it ... and how much running Linux affects the expected battery life.
>> Can you share your experience?
> 
> 
> See http://www.tabletpcbuzz.com/forum/topic.asp?TOPIC_ID=4451
> The guy make a real world benchmark and conclude that a 1 GHZ TM5800
> with latest CMS and PTT should be comparable with 1 GHZ PIIIm.
> Normally TM5800 users will say it is comparable to 600-900 MHz PIII.
> 
> About running Linux on it. Application launch time is not good
> (18 sec. to launch GNOME Help, 7 sec. to relaunch). But after that
> it seems like linux GUI apps are more responsive.
> Building software projects seem to take longer than it should be.
> Building OpenOffice.org take more than 4 days while it take
> about 1-2 days on PIII. I guess the CMS has to translate 'gcc'
> on every invokation?  If so, can the kernel help in any way?
> 


This raises a new question. How about a port of Linux to the "VLIW" so 
that we can skip x86 "code morphing" interelly?

I'm sure that 1GHz would benefit from it. Is it possible, Linus?

After googling a bit i went to
http://216.239.57.100/search?q=cache:GCP2Ecz931UJ:www.icsi.berkeley.edu/~fleiner/research.html+crusoe+linux+native+port&hl=en&ie=UTF-8

...But there isn't many more info. Is there any advantage?

Sorry for the OT... :)

Regards,
Nuno Silva



> Battery life and Linux should be Ok. You'll have 'longrun' utility
> to control cpu power consumption vs. performance. I understand
> that the CPU already control its power consumption itself, even
> without the help of the kernel, right?
> 

