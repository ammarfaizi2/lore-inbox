Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315857AbSEGPIA>; Tue, 7 May 2002 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSEGPH7>; Tue, 7 May 2002 11:07:59 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:41779 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315857AbSEGPH5>; Tue, 7 May 2002 11:07:57 -0400
Message-Id: <5.1.0.14.2.20020507153451.02381ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 May 2002 16:08:20 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.14 IDE 56
Cc: Padraig Brady <padraig@antefacto.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD7D36A.6050209@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:15 07/05/02, Martin Dalecki wrote:
>Uz.ytkownik Padraig Brady napisa?:
>>Am I going to have to parse hdparm output?
>>....
>>  geometry     = 2434/255/63, sectors = 39102336, start = 0
>>Am I going to need hdparm on my embedded system?
>
>Yes. Or just fsck hardcode the defaults.

This is stupid! And if that isn't obvious to you, you should think a bit 
more carefully...

Linux's power is exactly that it can be used on anything from a wristwatch 
to a huge server and that it is flexible about everything. You are breaking 
this flexibility for no apparent reason. (I don't accept "I can't cope with 
this so I remove it." as a reason, sorry).

As the new IDE maintainer so far we have only seen you removing one feature 
after the other in the name of cleanup, without adequate or even any at 
all(!) replacements, renaming all functions to hell and back, and breaking 
the ide core here there and everywhere. All critical bug fixes seem to have 
been contributed by other people looking at your code which doesn't inspire 
a lot of confidence in you... Even Alan Cox said a while ago that you have 
his vote of no confidence (probably slightly rephrased here) because of 
changes you were introducing and I tend to trust bearded kernel hackers 
from Whales. (-;

Aren't you noticing that something is wrong here???

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

