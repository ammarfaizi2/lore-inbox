Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbTAGXEv>; Tue, 7 Jan 2003 18:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTAGXEu>; Tue, 7 Jan 2003 18:04:50 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:43460 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267571AbTAGXEC> convert rfc822-to-8bit; Tue, 7 Jan 2003 18:04:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Honest does not pay here ...
Date: Tue, 7 Jan 2003 17:09:55 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10301071251280.421-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10301071251280.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301071709.56008.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 January 2003 02:58 pm, Andre Hedrick wrote:
> On Tue, 7 Jan 2003, Jesse Pollard wrote:
> > Personally, I view binary only drivers as evidence of incompetence, or
> > embarassement over how poor a design is in the first place...
>
> Funny how you would call a persons work who you trust in open source now
> becomes dirty in closed.  Next time you spout crap of this magnitude,
> remember who made possible for the DCFL "Defense Computer Forensics Lab",
> your cluster computers to use ATA by writing giving away almost all the
> pci chipsets supported to date.
>
> I am not incompetence or embarassement, just want to pay the mortgage.
> So why don't you offer to pay my mortgage and bills for the next 30 years?
>
> So from the "incompetence" and "embarassed" author of your disk drives,
> you are welcome.

Not quite the same thing. I'm referring to the hardware design. I've seen too
much crap hidden in drivers to try and coverup crappy hardware
design/implementation.

I would presume your cut would come from my willingness to purchace the
hardware. Your added value is a software demonstration of capability. My
contribution is to test your source under other versions of the kernel, and if
I improve/fix bugs that are then returned to the community which you then
merge into your driver back to the company. Then more hardware would get
sold, and you get another cut.

If they don't pay you for support, then you are not required to provide
additional support by merging, redesigning, or extending. Your contribution
to the company is to improve their sales.

I used to develop drivers for DEC hardware, for OSs that were NOT from DEC.
I was paid by those who used that hardware for additional sales (actually, 
they leased equipment/services for oil surveys). Why was DEC equipment
used?

1. full hardware documentation was available
2. it was the least expensive hardware
3. the devices worked (well.. up until they started trying to kill the PDP11s)

Out of the hardware designed by the company (not DEC), the only parts they
would NOT release was a piece of crap that was a radio ranging interface. It
did not even provide a synchronous parallel interface (we were forced to read
the device twice and compair the reads. If they didn't match, then we had to 
read it again and compair. If this didn't match the preceeding answer, we had 
to start over... If two of them matched then we got a good read... 90 times 
out of a 100...)

Oh, I almost forgot the other crappy one - a spread spectrum modem that would 
receive 130 to 140 bytes for every 128 bytes sent... We had to implement a 
full packet protocol just to send 15 bytes (it wouldn't start tansmitting 
until the 16th byte was sent to the device). Then we had to be sure to send
AT LEAST enough to fill out 128 bytes, even if we didn't have that much data.
(I don't think it stopped transmitting until it had sent 128) and nulls 
weren't accepted for some reason. I could not convince the designer that
it would be much better to put the packet protocol in the modem itself and
hide those bad bytes.

Neither of these were very acceptable to the clients... but we hid most of
the crap in the drivers.

In your case, If I can't get the full specs (even to understand what the 
device is supposed to do), then I don't really want it. If I recieve drivers
that work, and available in source (all of mine currently are this way), then
I'll use it, and I am willing to purchase more of them.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
