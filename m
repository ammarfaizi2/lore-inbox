Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290281AbSAOV1a>; Tue, 15 Jan 2002 16:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289686AbSAOV1X>; Tue, 15 Jan 2002 16:27:23 -0500
Received: from mail.spylog.com ([194.67.35.220]:60649 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S289680AbSAOV1L>;
	Tue, 15 Jan 2002 16:27:11 -0500
Date: Wed, 16 Jan 2002 00:28:57 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: http://www.spylog.ru
X-Priority: 3 (Normal)
Message-ID: <15850171252.20020116002857@spylog.ru>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re[2]: 3.5G user space speed
In-Reply-To: <3C4499A3.781E5A85@didntduck.org>
In-Reply-To: <16247691406.20020115234737@spylog.ru>
 <3C4499A3.781E5A85@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Brian,

Wednesday, January 16, 2002, 12:05:39 AM, you wrote:


Well. May be you can tell about the numbers a bit ? I can chose 3.0G
for user instead of 3.5G for user with not really huge loss, but I'd
like to know how much it will increase speed and in which cases, also
about standard 2/2 mode.

>>
>>   2.4.xaa Series as well as  SuSE kernels have  3.5G userspace option,
>>   which seems to be quite useful, therefore I see it's not included
>>   is stock kernel for some reasons. Also I've heard this
>>   configuration may have some performance problems.
>> 
>>   Can anyone comment on this topic ?
>> 
>>   I need large amount of address space for my application but I also
>>   need to get as much I/O performance as it's possible, so I can switch
>>   to 3.0/1.0 memory distribution if it will benefit here.

BG> You can't have it both ways with the x86 (speed vs. large userspace). 
BG> Kernel 2.5 may help a bit here because changes were made to allow DMA
BG> from all memory (subject to card limitations), lessening the burden for
BG> direct-mapped memory.  Otherwise you'll need to move to a 64-bit arch.




-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

