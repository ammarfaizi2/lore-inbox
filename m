Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273672AbRIQT6n>; Mon, 17 Sep 2001 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273673AbRIQT6d>; Mon, 17 Sep 2001 15:58:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:51330 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273669AbRIQT6T>; Mon, 17 Sep 2001 15:58:19 -0400
Date: Mon, 17 Sep 2001 15:58:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Fries <dfries@mail.win.org>
cc: John Weber <john@worldwideweber.org>, linux-kernel@vger.kernel.org
Subject: Re: how to get cpu_khz?
In-Reply-To: <20010917145130.C4041@aerospace.fries.net>
Message-ID: <Pine.LNX.3.95.1010917155650.17392A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, David Fries wrote:

> On Mon, Sep 17, 2001 at 03:11:26PM -0400, John Weber wrote:
> > David Fries wrote:
> > > 
> > > I'm using the TSC of the Pentium processors to get some precise timing
> > > delays for writing to a eeprom (bit banging bus operations), and it
> > > works just fine, but the cpu_khz variable isn't exported to a kernel
> > > module, so I hardcoded in my module.  It works fine for that one
> > > system, but obviously I don't want to hard code it for the general
> > > case.  I guess I could write my own routine to figure out what the
> > > cpu_khz is, but it is already done, so how do I get access to it?
> > 
> > I don't know of any official way of doing this, but here's some 
> > code (written by aa) that accomplishes this.
> 
> For a user space program you could just read /proc/cpuinfo, I'm
> actually writing a kernel driver, maybe I wasn't clear enough.  I'm
> just frustrated because the variable I'm after, cpu_khz is already
> calculated at boot time (that's where /proc/cpuinfo gets its data) and
> that variable doesn't appear to be exported to the rest of the kernel,
> either that or I'm just missing something, which I would rather be the
> case at this point.
> 

Ask Alan to export it by default. If no-go, export it in your
configuration.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


