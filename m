Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291563AbSBHNPb>; Fri, 8 Feb 2002 08:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291564AbSBHNPV>; Fri, 8 Feb 2002 08:15:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:24592 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291563AbSBHNPI>; Fri, 8 Feb 2002 08:15:08 -0500
Message-ID: <3C63CF54.9090308@evision-ventures.com>
Date: Fri, 08 Feb 2002 14:15:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020129
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz,
        andre@linuxdiskcert.org
Subject: Re: ide cleanup
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz> <3C63C5EF.4050403@evision-ventures.com> <20020208133755.A10250@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Fri, Feb 08, 2002 at 01:34:55PM +0100, Martin Dalecki wrote:
>
>>>Hi!
>>>
>>>IDE is
>>>* infested with polish notation
>>>
>>I don't see any polish notation there. Could you please explain what you 
>>mean with this note?
>>
>
>I think Pavel meant what I think is called "hungarian notation", adding
>_t's to type identifiers or adding _i or i_ to integer variables.
>
The encoding of type signatures in function names is indeed called 
hungarian notation.
The _t at the end of type names is a POSIX habit of markup for system 
defined types - this should *NOT*
be used in user land programms but is OK for the kernel. However for the 
ide drivers it's indeed unnecessary
code noise.

Polish notation is the anglo-saxon term for a mathematical expression 
syntax which is avoiding
parents by not using an "in between" operator notation but using 
functional notation instead.
It was invented by ?ukasiewich at the beginning of the last century for 
formal logic and is indeed more
convenient there if you start to deal with long expressions.... Just to 
clarify the terms OK?

