Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUBJUBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUBJUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:01:46 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:12817 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265943AbUBJUBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:01:43 -0500
Message-ID: <4029398D.4010705@tmr.com>
Date: Tue, 10 Feb 2004 15:05:33 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wrlk@riede.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.3-rc1] ide-scsi burning broken
References: <1nwBu-35x-11@gated-at.bofh.it>
In-Reply-To: <1nwBu-35x-11@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willem Riede wrote:
> On Mon, 09 Feb 2004 20:10:37 +0200, Markus Hästbacka wrote:
>                 
> 
>>Hi list,
>>I was going to burn a cd earlier today, and I noticed it wont work in
>>2.6.3-rc1, k3b (the burning software) just freezed in 'D' state, and
>>after a moment I got something like this in my dmesg:
>>/dec/sr0 drive not ready!
>>/dec/sr0 drive not ready!
>>/dec/sr0 drive not ready!
>>[x1000]
>>So I guess the ide-scsi patches broke up things.
>>
>>The burning in 2.6.1-mm4 works fine.
>>
>>I know I should use ide-cd whatever, but I've always done it with
>>ide-scsi and I wont easily change that.
> 
>                 
> I doubt that changes in ide-scsi caused this, you just ran out of luck :-(
> Since you're not supposed to use ide-scsi for cd writing (as you admit
> knowing), nobody is going to help you with this problem...

I think CD burning is like the canary in the coal mine, if it stops 
working something is broken. It may be "better" to burn with ide-cd, in 
some hope of avoiding overhead which is small beyond measurement for 
data CDs on most systems, but it should work, and the fact that it has 
stopped working probably indicates something has changed which will 
later rise up to bite us with IDE tape, or MO, or avoiding ide-floppy 
for ZIP, or whatever.

If you think of it as a test program for the interface it matches 
reality better, except that many people cross boot between 2.4 and 2.5, 
don't want to build using Joreg's odd idea of header files, and 
generally use this interface for production use.

-- 
bill davidsen, TMR
