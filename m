Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRHBTz6>; Thu, 2 Aug 2001 15:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269102AbRHBTzt>; Thu, 2 Aug 2001 15:55:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17280 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269082AbRHBTza>; Thu, 2 Aug 2001 15:55:30 -0400
Date: Thu, 2 Aug 2001 15:54:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33.0108021206570.21298-100000@heat.gghcwest.com>
Message-ID: <Pine.LNX.3.95.1010802154206.6297A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
[SNIPPED...]

> 
> My process are not small.  They are huge.  They take up nearly all
> available memory.  And then when a lot of file I/O kicks in, they get
> swapped out in favor of RAM, then the thrashing starts, and the box goes
> to la la land.
> 
> Are you saying that I can expect any userland process to be able to take
> the box down?

Not if you enable user quotas.

> Shit, why don't I just go back to DOS?

Because 640k doesn't hack it.

Seriously, it doesn't do any good to state that something sucks. You
need to point out the specific problem that you are experiencing.
"going to la la land.." is not quite technical enough. In fact, you
imply that the machine is still alive because of "disk thrashing".
If, in fact, you are a member of the Association for Computing Machinery
(so am I), you should know all this. Playing Troll doesn't help.

If you suspend (^Z) one of the huge tasks, does the thrashing stop?
When suspended, do you still have swap-file space?
Are you sure you have managed the user quotas so that the sum of
the user's demands for resources can't bring down the machine?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


