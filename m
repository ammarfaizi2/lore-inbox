Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVBGQ7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVBGQ7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVBGQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:59:09 -0500
Received: from alog0147.analogic.com ([208.224.220.162]:7296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261194AbVBGQ66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:58:58 -0500
Date: Mon, 7 Feb 2005 11:55:31 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Chris Friesen <cfriesen@nortel.com>
cc: Lee Revell <rlrevell@joe-job.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Pavel Roskin <proski@gnu.org>, Joseph Pingenot <trelane@digitasaru.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: Please open sysfs symbols to proprietary modules
In-Reply-To: <420791D7.3020408@nortel.com>
Message-ID: <Pine.LNX.4.61.0502071122410.22503@chaos.analogic.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain> 
 <20050203000917.GA12204@digitasaru.net>  <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>
  <692795D1-758E-11D9-9D77-000393ACC76E@mac.com> <1107674683.3532.26.camel@krustophenia.net>
 <420791D7.3020408@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Chris Friesen wrote:

> Lee Revell wrote:
>> On Wed, 2005-02-02 at 21:50 -0500, Kyle Moffett wrote:
>> 
>>> It's not like somebody will have
>>> some innate commercial advantage over you because they have your
>>> driver source code.
>> 
>> 
>> For a hardware vendor that's not a very compelling argument.  Especially
>> compared to what their IP lawyers are telling them.
>> 
>> Got anything to back it up?
>
> I have a friend who works for a company that does reverse-engineering of ICs. 
> Companies hire them to figure out how their competitor's chips work.  This is 
> the real threat to hardware manufacturers, not publishing the chip specs.
>
> Having driver code gives you the interface to the device.  That can be 
> reverse-engineered from watching bus traces or disassembling binary drivers 
> (which is how many linux drivers were originally written). Companies have 
> these kinds of resources.
>
> If you look at the big chip manufacturers (TI, Maxim, Analog Devices, etc.) 
> they publish specs on everything.  It would be nice if others did the same.
>
> Chris

I also have first-hand knowledge. Once there was a company called
Data Precision. Just point your favorite search-engine to that
name. They were a wholly owned subsidiary of Analogic. They
no longer exist. Data Precision would take a year or more
to develop a product. Six weeks after it was available on
the market, it would have been cloned by Pacific-rim companies
and dumped into the US at below US manufacturing cost. Even
Tektronix and Hewlett-Packard had these problems. What they
did, to assure survival, was to create custom silicon and
hide the inner-workings of everything. You can't even get
a schematic anymore. Data Precision used to provide schematics
so test equipment could be repaired. This resulted in the
death of the division.

The world is filthy with thieves. One of Data Precision's
products had a 'glitch' in its spectrum analyzer display.
This was because of a trade-secret method of performing
a FFT that wasn't "exactly" a FFT, but good enough for a
screen-display. This allowed fast screen updates (over
100 times per second) so that one could use the analyzer
as a RF "sniffer" just like analog spectrum analyzers.
Internally, the real FFT was performed so accurate readings
could be made once somebody let the machine stabilize.
Everything, including the glitch, was copied verbatum.

The source-code wasn't made available, but the internal
TMS320/C30 DSP was accessible using a IEEE serial port.
They just sucked out the binary and used a disassembler
to see where I/O was done, then just copied the binary
directly. They didn't even need the source-code. The
binary from one of the clones was identical to the
binary from the original product, simply a copy.

So companies that want to stay around for awhile don't
devulge anything that will expedite the cloning of
their hardware. It is particularly important where
name recognition is meaningless. If you have a screen-
card in your box that emulates your favorite vendor's
screen card, do you care if it's a non-name clone
as long as it works? Do you even know if your favorite
vendor stole his design from somebody else in the first
place?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
