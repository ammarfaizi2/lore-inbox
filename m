Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278415AbRJMV3S>; Sat, 13 Oct 2001 17:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278417AbRJMV3I>; Sat, 13 Oct 2001 17:29:08 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41199
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278415AbRJMV27>; Sat, 13 Oct 2001 17:28:59 -0400
Date: Sat, 13 Oct 2001 14:29:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Patrick McFarland <unknown@panax.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Message-ID: <20011013142926.B28547@mikef-linux.matchmail.com>
Mail-Followup-To: Mark Hahn <hahn@physics.mcmaster.ca>,
	Patrick McFarland <unknown@panax.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011013130228.E249@localhost> <Pine.LNX.4.10.10110131305490.17521-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10110131305490.17521-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 01:48:05PM -0400, Mark Hahn wrote:
> > Now, the great kernel hacker, ac, said that 2.2 is better at vm in low
> > memory situations than 2.4 is. Why is this? Why hasnt someone fixed the 2.4
> > code? 
> 
> not to slight TGKH AC, but he's also the 2.2 maintainer; perhaps there's 
> some paternal protectiveness there ;)
> 
> my test for VM is to compile a kernel on my crappy old BP6 with mem=64m;
> I use a dedicated partition with a fresh ext2, unpack the same source tree,
> make -j2 7 times, drop 1 outlier, and average:
> 
> 2.2.19: 584.462user 57.492system 385.112elapsed 166.5%CPU
> 2.4.12: 582.318user 40.535system 337.093elapsed 184.5%CPU
>

Is this:
> 2.2.19: 
584.462user 
57.492system 
385.112elapsed 
166.5%CPU

> 2.4.12: 
582.318user 
40.535system 
337.093elapsed 
184.5%CPU

???

If so, then 2.4.12 won on user, system and elapsed.  What's with the CPU
percentage?  Are you on a dual system?

> notice that elapsed is noticably faster even than the 1+17 second
> benefit to user and system times.  Rik's VM seems to be slightly

No, that's Andrea's VM (since 2.4.10pre11).  Rik's is in 2.4.xx-ac.

Mike
