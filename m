Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318786AbSIIShM>; Mon, 9 Sep 2002 14:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318789AbSIISg6>; Mon, 9 Sep 2002 14:36:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46722 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318786AbSIISft>; Mon, 9 Sep 2002 14:35:49 -0400
Date: Mon, 9 Sep 2002 14:43:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Phillips <phillips@arcor.de>
cc: Imran Badr <imran.badr@cavium.com>, "'David S. Miller'" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
In-Reply-To: <E17oT6L-0006qS-00@starship>
Message-ID: <Pine.LNX.3.95.1020909144217.18372A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Daniel Phillips wrote:

> On Monday 09 September 2002 20:00, Richard B. Johnson wrote:
> > For some reason, (claimed performance reasons) user-mode code
> > has to be able to get data directly from hardware with no
> > intervening copy operation. I think any claimed advantage goes
> > away when you look at the overhead necessary for user-mode
> > code to sleep before, and awaken after, the DMA operation but
> > often marketing departments make those decisions.
> 
> Pfft.  Try turning off ide dma and see what happens.

I know that DMA works, I'm talking about DMA direct-to-user
which is not what the file-systems that use DMA do.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

