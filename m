Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131126AbRAFL0N>; Sat, 6 Jan 2001 06:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRAFL0C>; Sat, 6 Jan 2001 06:26:02 -0500
Received: from colorfullife.com ([216.156.138.34]:5130 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131126AbRAFL0A>;
	Sat, 6 Jan 2001 06:26:00 -0500
Message-ID: <3A5700C4.2A6D867B@colorfullife.com>
Date: Sat, 06 Jan 2001 12:25:56 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: ik5pvx@penny.ik5pvx.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0: apache doesn't start
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this in another mail:

Kevin Fenzi wrote:
> Duh. 
> 
> I figured out the problem. In 2.4.0-test13-pre3 is the introduction of 
> the shmall sysctl. I had installed a package called powertweak a while 
> back. It looks like powertweak sets any sysctl it doesn't know to 0. 
> 
> So, the problem was that there was no shared memory for X. ;( 
> 
> I set that up to a reasonable level and all is well. 
> 
> sorry for the wild goose chase. :( 
> 
> kevin 
> - 

Could you check your /proc/sys/kernel/shmall value?
If 2.4 is really incompatible with powertweak, perhaps a warning should
be added to the release notes.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
