Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292687AbSCIM6b>; Sat, 9 Mar 2002 07:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSCIM6V>; Sat, 9 Mar 2002 07:58:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:24587 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292687AbSCIM6J>; Sat, 9 Mar 2002 07:58:09 -0500
Message-ID: <3C8A0693.3010002@evision-ventures.com>
Date: Sat, 09 Mar 2002 13:56:51 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 18
In-Reply-To: <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>	<3C88DCEF.5000708@evision-ventures.com> <200203081642.g28Gg1518485@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> Martin Dalecki writes:
> 
>>- Add EXPORT_SYMBOL(ide_fops) again, since it's used in ide-cd.c add
>>   a note there that this is actually possibly adding the same
>>   device twice to the devfs stuff.
>>
> 
> If it is adding the same device twice, that's definately a
> bug. Duplicate devfs entries are not allowed.

Thank you for reafirmation. As noted in the code
I will re-check this again soon.


