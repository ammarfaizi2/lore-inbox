Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbRGUD6p>; Fri, 20 Jul 2001 23:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbRGUD6Z>; Fri, 20 Jul 2001 23:58:25 -0400
Received: from ohiper1-16.apex.net ([209.250.47.31]:55680 "EHLO
	jacana.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S267564AbRGUD6X>; Fri, 20 Jul 2001 23:58:23 -0400
Date: Fri, 20 Jul 2001 22:58:04 -0500
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Please suggest me
Message-ID: <20010720225804.A2613@jacana.dyn.dhs.org>
In-Reply-To: <3B5874AC.43D2E698@monmouth.com> <Pine.LNX.3.95.1010720151621.6191A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010720151621.6191A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Jul 20, 2001 at 03:18:44PM -0400
From: Aaron Smith <yoda_2002@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 20, 2001 at 03:18:44PM -0400, Richard B. Johnson wrote:
> On Fri, 20 Jul 2001, Dipak Biswas wrote:
> 
> > Hi All,
> >     I'm quite new to linux world. I've a very awkard question for you.
> > That is: I'm writting an user process, where I need all outgoing
> > IP packets to be blocked and captured. First, is it really possible? If
> > yes, how? I don't want to make any kernel source code changes. A wild
> > guess: by configuration changes, is it possible to make IP process write
> > on to a particular FD which I can read when I require?
> > 
> > Thanks,
> > dipak
> > 
> 
> Get the source-code of `tcpdump` and see how packet capturing is done.
> You can also look at `ipchains` to see how to block packets.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I would suggest using IPTables, personally, that's what I use for all of my firewall-type needs.

-- 
-Aaron

Don't hate yourself in the morning, sleep till noon
