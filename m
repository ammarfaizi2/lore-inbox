Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316983AbSEWSuY>; Thu, 23 May 2002 14:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316984AbSEWSuX>; Thu, 23 May 2002 14:50:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14863 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316983AbSEWSuV>; Thu, 23 May 2002 14:50:21 -0400
Message-ID: <3CED2B11.90301@evision-ventures.com>
Date: Thu, 23 May 2002 19:46:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kb25 manual [was Re: [Linux-usb-users] Re: What to do with all
 of the USB UHCI drivers in the kernel?]
In-Reply-To: <20020523154252.GA24260@louise.pinerecords.com> <Pine.LNX.4.33L2.0205230850080.4119-100000@dragon.pdx.osdl.net> <20020523160136.GC24260@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Tomas Szepe napisa?:
>>| > BTW> one of the reasons I never bothered myself with kbuild-2.5
>>| > is for example that nio matter how frequently Keith
>>| > is advertising it - every time I go there to have a look at it
>>| > at sf what I find is a scatter heap of .tar.gz. The documentation
>>| > about how to install it makes me nervous, since I would
>>| > rather just expect a diff and a README how to use it, so I never
>>| > look after it.
>>|
>>| Duh... All you need is the core package (diff #1), the architecture
>>| independent modifications package (diff #2) and finally diff #3 that
>>| adds the arch-specific stuff. Everything's in a single list on sf.
>>|
>>| then just do s/t like
>>| cd /usr/src/linux-2.4.19-pre8 && zcat \
>>| 	../kbuild-2.5-core-14.gz \
>>| 	../kbuild-2.5-common-2.4.19-pre8-1.gz \
>>| 	../kbuild-2.5-i386-2.4.19-pre8-1.gz \
>>| 	| patch -sp1
>>|
>>| and read the comprehensive manual in Documentation/kbuild/
>>|
>>| What's there to be nervous about?


Well perhaps lazy would be more adequate to express my feelings.
First why the hell three different diff files?
I don't give a damn witt about what the internal
architecure of it is. And I don't wan't to miss any
non i386 build. (I have ARM for example as well.)
I don't wan't to care whatever this is all complete.
And I just expect the documentation about how to use
it right at the top in README or INSTALL. I'm a human
and humans tend to love to stick to habits. And I already
got in to the habit of:

- One thing one patch.
- Something to compile look after README or INSTALL first there.

Even the kbuild name isn't intuitive
new-kernel-build would be more clear.

I really just wan't to see how it works first and I wan't
to see that it indeed work's better then what I have
already before I look at how it is done

Call me arrogant (and most propably it would be justifyed in
this case), but this aggressive splitup gives me
prejudictions about the whole thing simply beeing overdesigned...

