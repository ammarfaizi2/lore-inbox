Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271223AbRHOPVf>; Wed, 15 Aug 2001 11:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271230AbRHOPVZ>; Wed, 15 Aug 2001 11:21:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:45955 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271223AbRHOPVJ>; Wed, 15 Aug 2001 11:21:09 -0400
Date: Wed, 15 Aug 2001 11:21:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Steve Hill <steve@navaho.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.4.21.0108151605180.2107-100000@sorbus.navaho>
Message-ID: <Pine.LNX.3.95.1010815111856.28263A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Steve Hill wrote:

> 
> Until recently I've been using the 2.2.16 kernel on Cobalt Qube 3's, but
> I've just upgraded to 2.4.6.  Since there's no mouse, keyboard, etc, there
> isn't much entropy data.  I had no problem getting plenty of data from
> /dev/random under 2.2, but under 2.4.6 there seems to be a distinct lack
> of data - it takes absolutely ages to extract about 256 bytes from it
> (whereas under 2.2 it was relatively quick).  Has there been a major
> change in the way the random number generator works under 2.4?
> 
> -- 
> 

Same problem on 2.4.1. The first 512 bytes comes right away if
/dev/random hasn't been accessed since boot, then the rest trickles
a few words per second.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


