Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270930AbRHTNZx>; Mon, 20 Aug 2001 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271132AbRHTNZn>; Mon, 20 Aug 2001 09:25:43 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:27109 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271118AbRHTNZb>;
	Mon, 20 Aug 2001 09:25:31 -0400
Date: Mon, 20 Aug 2001 14:25:39 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Schwartz <davids@webmaster.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Message-ID: <2246712912.998317539@[10.132.112.53]>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMGEOEDEAA.davids@webmaster.com>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMGEOEDEAA.davids@webmaster.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Better than the necessary 1 jiffie on non-i386 platforms and some
>> i386 platforms.
>
> 	On those platforms, you simply can't have good entropy and still have
> user accounts on the box with the default hardware. Sorry, the hardware
> just doesn't permit it. You would have to set up some secure way to draw
> entropy off an external pool, there's just nothing else you can do. (I
> believe there are non-x87 platforms that have good timers, just not all
> of them.)

Many non-i386 platforms have more finely grained timers than 1 jiffie.
The problem is the code doesn't use them. So my point is, it seems
illogical to throw stones at (often) theoretical issues with Robert's
patch, when people's energy would be better diverted to help fix up
hole in the current implementation.

--
Alex Bligh
