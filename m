Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274234AbRIZKjA>; Wed, 26 Sep 2001 06:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274237AbRIZKiu>; Wed, 26 Sep 2001 06:38:50 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:56334 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S274234AbRIZKij>; Wed, 26 Sep 2001 06:38:39 -0400
Message-ID: <3BB1AF00.3010201@eisenstein.dk>
Date: Wed, 26 Sep 2001 12:33:36 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Moscatt <pmoscatt@yahoo.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Attempting to kill the idle task ??
In-Reply-To: <20010926102805.80450.qmail@web14702.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Moscatt wrote:

> I got the following error:
> 
> "nic: Attempting to kill the idle task!
> In idle task - not stncing
> <1> Unable to handle kernel NULL pointer dereference
> at virtual address 00000000"
> 
> Then I get a screen full of numbers and end up with:
> 
> "nic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing"
> 
> 
> What have I done/not done to have this problem ?

I'm no expert on this, but it looks like a kernel Oops to me - You 
should read /usr/src/linux/Documentation/oops-tracing.txt

The "screen full of numbers" you are refering to is a dump of the 
various machine register states at the time of the crash and a backtrace 
of the instructions that led up to the crash. You should copy it all 
down and run it through the "ksymoops" tool to produce output that will 
be usefull to the kernel developers, then post the ksymoops output.


Best regards,
Jesper Juhl
juhl@eisenstein.dk


