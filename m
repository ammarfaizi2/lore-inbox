Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287332AbSACPqG>; Thu, 3 Jan 2002 10:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287328AbSACPp4>; Thu, 3 Jan 2002 10:45:56 -0500
Received: from [195.63.194.11] ([195.63.194.11]:5903 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S287325AbSACPpq>;
	Thu, 3 Jan 2002 10:45:46 -0500
Message-ID: <3C347A12.3070404@evision-ventures.com>
Date: Thu, 03 Jan 2002 16:34:42 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Thomas Gschwind <tom@infosys.tuwien.ac.at>
CC: Nathan Bryant <nbryant@allegientsystems.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <3C3382CA.3000503@allegientsystems.com> <3C345493.5040800@evision-ventures.com> <20020103154718.C32419@infosys.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gschwind wrote:

>On Thu, Jan 03, 2002 at 01:54:43PM +0100, Martin Dalecki wrote:
>
>>Nathan Bryant wrote:
>>
>>>Can you have a look at Doug Ledford's 0.13 driver? this incorporates 
>>>most or all of the fixes you mentioned, except for SiS support, and 
>>>some other fixes; it hasn't been incorporated into the main kernel 
>>>quite yet because it needs more testing. 
>>>
>>
>>Let me allow for a bit of advertising... Hist SiS changes work fine for 
>>me with the exception
>>of recording.,
>>
>
>I did not have the pointer to Doug's latest version of the i810
>driver.  I will integrate my patches into his latest version and will
>send it to the list.  I will also have another look at recording but
>it would be great if you could be a little bit more specific of your
>recording results.
>
>What happened? 
>  How did you try to record?
>  Did the system crash?  
>  Did the program you used for recording crash?
>  Was the recording trash?  
>  How did it sound?  To fast? To slow? Crackling? Random noise? All of it?
>  What hardware do you have?  K7S5A or a different MB with a SiS735 chipset? 
>

Well my hardware is an Elitegroup, AMI-BIOS, with a SiS735. The AC'97 
codec chip, which doesn't
get recognized properly by linux, is a avance logic (AL107) chip. The 
whole thing  is running
at a fixed 48000 Hz clock, which is derived from the USB host bridge.

XMMS is working fine, since it does understand the issue of fixed 
frequency PCM
decoders. mplayer is usable with -ao sdl:esd, aka. piping the output 
through esd, since the
esd doesn't have problems with fixed chip codecs. However the sound 
frequency
transponder in ESD is really navie. It doesn't do any true filtering 
apparently, so
one can hear the overleap frequency from 44.1 kHZ to 48kHz for
example. The artsd from KDE as usuall is failing blatantly and locks the 
system hard...
And I don't have neither the time, nor inclination for debuggin it...
(Unless I could compile the whole KDE proerply with some recent gcc-3.x 
for RedHat ;-).

Recodring did lockup the system hard as well immediately, no matter what.

However I will certainly try the whole again, since it would be really 
nice to have the whole
stuff running properly under KDE. I'm not going to use GNOME in no time ;-).

N'f info?

