Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSHCSQl>; Sat, 3 Aug 2002 14:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317649AbSHCSQY>; Sat, 3 Aug 2002 14:16:24 -0400
Received: from [200.181.158.64] ([200.181.158.64]:14084 "EHLO
	firewall.PolesApart.dhs.org") by vger.kernel.org with ESMTP
	id <S317642AbSHCSOg>; Sat, 3 Aug 2002 14:14:36 -0400
Date: Sat, 3 Aug 2002 15:18:01 -0300 (BRT)
From: Alexandre Pereira Nunes <alex@PolesApart.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: Re: some questions using rdtsc in user space
In-Reply-To: <006901c23a81$08f52170$0100a8c0@brianwinxp>
Message-ID: <Pine.LNX.4.44.0208031507370.991-100000@PolesApart.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Brian Evans wrote:

> In a similar case here we just added a PIC controller to buffer
> the commands and results. They are cheap and easy to program
> and if your using devices that are very 'dumb' can take a lot
> of headaches out of making sure timing is correct. Another
> advantage is you get easier use in all operating systems.
>
> Brian
>

My friend had this idea, and we are considering switching to using the
serial port in this case. We're just trying to see what we can do in
software, if we got nothing but bad results, that (using a pic) will
eventualy become our main choice. The reason to nothing doing so is that
the device is somewhat tolerant, so if we got good average results, maybe
we keep it as is. But if we decide to use the serial port, we'd better
using the pic solution anyway, killing both problems (the parallel port
uses to be used by a printer, while almost everyone has a spare serial
port). In future we might consider using USB, It seems that there's a PIC
series with usb interfacing, but for now that's future.

Thanks for your help,

Alexandre

