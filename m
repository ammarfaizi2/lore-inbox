Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131120AbRBLW32>; Mon, 12 Feb 2001 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbRBLW3T>; Mon, 12 Feb 2001 17:29:19 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:21773 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S131120AbRBLW3H>;
	Mon, 12 Feb 2001 17:29:07 -0500
Message-ID: <3A886432.5070302@megapathdsl.net>
Date: Mon, 12 Feb 2001 14:31:14 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-pre2 i686; en-US; m18) Gecko/20010208
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Laberge <mlsoft@videotron.ca>
CC: Juergen Schneider <juergen.schneider@tuxia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <20010201183231.A373@tuxia.com> <3A880004.51C92911@videotron.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Laberge wrote:

> Juergen Schneider wrote:
> 
> 
>> Hello everybody,
>> 
>> I've created a patch for kernel 2.4.1 that adds some fancy options for
>> the framebuffer console driver concerning the boot logo.
>> I've added logo animation and logo centering.
>> People may find this not very useful but nice to look at. :-)
>> 
>> It can be downloaded from:
>>    <ftp://ftp.tuxia.com/pub/linux/tuxia/anim-logo/AnimLogo.tgz>
>> 
>> With this tar ball comes the patch for kernel 2.4.1 and a small
>> program called xpm2splash to create animated linux_logo.h files
>> from XPM files.
>> The patch also contains an animated boot logo (that's why it is
>> so big).
>> It is the dancing penguin I've taken from the apache default
>> configuration of a SuSE 6.4 distribution.
>> (BTW who created this nice animation???)
>> 
>> So, try it and send your comments.
>> 
>> Juergen Schneider
>> 
>> PS: The patch should work with kernel 2.4.0 too.
>> 
>> PPS: Our FTP server seems to have some problems with the "ls"
>>      command. You should use "ls -l" or "dir" to get a
>>      directory listing. Sorry for that.
>> 
>> --
>> Dipl.-Inf. Juergen Schneider                    <juergen.schneider@tuxia.com>
>> TUXIA Deutschland GmbH
> 
> 
> I beleive it is a very good idea... there has been many objections where
> SYSTEM-HANG or CRASH or ANY-BAD-THING
> would be difficult to trace for the geek... BUT , are you all believing the
> system will be crashing most of the time, or will it be
> running perfectly most of the time...

Linux does crash early in the boot process sometimes.  Folks are
correct to be worried about handling these early crashes in such
a way that the user can learn what is going wrong with the OS.

<snip>

> I believe linux should be one of those systems... you start it and then use
> it... it don't crash, don't hang...   it works...

It does crash and users can't know when it will happen 
ahead of time.  For example, I add a new piece of 
hardware that triggers a driver bug and BANG, the 
machine locks up on boot.  

Now, we can still have a "innocuous pretty boot" process,
as long as a boot parameter can be passed so that when
a kernel is crashing early in the boot process, the user
can disable the prettyboot and get to all the kernel 
messages.

<snip>

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
