Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267234AbRGTTTR>; Fri, 20 Jul 2001 15:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbRGTTTI>; Fri, 20 Jul 2001 15:19:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267234AbRGTTSx>; Fri, 20 Jul 2001 15:18:53 -0400
Date: Fri, 20 Jul 2001 15:18:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dipak Biswas <dipak@monmouth.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Please suggest me
In-Reply-To: <3B5874AC.43D2E698@monmouth.com>
Message-ID: <Pine.LNX.3.95.1010720151621.6191A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 20 Jul 2001, Dipak Biswas wrote:

> Hi All,
>     I'm quite new to linux world. I've a very awkard question for you.
> That is: I'm writting an user process, where I need all outgoing
> IP packets to be blocked and captured. First, is it really possible? If
> yes, how? I don't want to make any kernel source code changes. A wild
> guess: by configuration changes, is it possible to make IP process write
> on to a particular FD which I can read when I require?
> 
> Thanks,
> dipak
> 

Get the source-code of `tcpdump` and see how packet capturing is done.
You can also look at `ipchains` to see how to block packets.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


