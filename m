Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291121AbSBLPgk>; Tue, 12 Feb 2002 10:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291124AbSBLPgU>; Tue, 12 Feb 2002 10:36:20 -0500
Received: from [195.63.194.11] ([195.63.194.11]:10510 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291121AbSBLPgK>; Tue, 12 Feb 2002 10:36:10 -0500
Message-ID: <3C69365C.9060603@evision-ventures.com>
Date: Tue, 12 Feb 2002 16:35:56 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz> <3C693357.8000204@evision-ventures.com> <20020212162834.A25617@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>>BTW.> Since there is no longer any difference about the request head
>>handling between IDE and SCSI, what about the idea of moving the whole
>>ide interface stuff under the umbrella of SCSI host adapter? This
>>would be a true cleanup and make the whole ide-scsi and ide-atapi mess
>>go away. IDE is moving fast toward SCSI on the logical level anyway
>>and it would make the hwif macro/lookup crap in the ide code go
>>magically way! At least this generic device handler search stuff
>>should be merged between them (I'm trully tempted to give it a shoot
>>this afternoon.) The only thing it could result in, which would maybe
>>surprise some would be the fact that the major of his root device
>>could just go suddenly away... But hey! What's the heck - we are in
>>odd kernel series anyway ;-).
>>
>
>This is an idea I'm toying with for quite a long time already. And I
>think this is a good idea as well. I have no more time to spend coding
>today, so if you have the afternoon, but I'll definitely find some to
>read the diff if you do this change!
>

Well could you do me a mall favour of dumping a combined ide cleanup 
relative to 2.5.4 on me?
In contrast to Linus I don't like scattered patches ;-). I will at least 
give it a deep code look today for the
ide-cdrom stuff, becouse it was always annoying to me that the default 
distribution setup
is using the ide interface to my CD-recorder and every single recorder 
aplication out there
is using the scsi interface instead.


