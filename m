Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265904AbRFYUA5>; Mon, 25 Jun 2001 16:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265905AbRFYUAj>; Mon, 25 Jun 2001 16:00:39 -0400
Received: from adsl-65-68-16-200.dsl.ltrkar.swbell.net ([65.68.16.200]:22619
	"EHLO etmain.edafio.com") by vger.kernel.org with ESMTP
	id <S265904AbRFYUAY> convert rfc822-to-8bit; Mon, 25 Jun 2001 16:00:24 -0400
Subject: RE: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Date: Mon, 25 Jun 2001 14:55:29 -0500
Message-ID: <3BDF3E4668AD0D49A7B0E3003B294282BC95@etmain.edafio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Thread-Topic: VIA Southbridge bug (Was: Crash on boot (2.4.5))
content-class: urn:content-classes:message
Thread-Index: AcD9RL2A00f4ZAneTQWC1C+aqER/kwAa5gew
From: "Andy Ward" <andyw@edafio.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Steven Walter" <srwalter@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh really?   I have my memory timings set to 133/cas2/6-4-4-4.  One
wonders... *ponder*

I have noticed some general flakyness (hard to pin down) on the system,
though...  random program crashes, minor visual corruption in X (which
fixes itself when you move things around), etc...  Anyone want to take a
swing at that?

-- andyw

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, June 25, 2001 2:07 AM
To: Steven Walter
Cc: Andy Ward; linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))


> Great, glad to here it.  Who (if anyone) is still attempting to
unravel
> the puzzle of the Via southbridge bug?  You, Andy, should try and get
in
> touch with them and help debug this thing, if you're up to it.

The IWILL problem seems unrelated. Its the board that more than others
people
report fails totally when streaming memory copies using movntq
instructions.

The Athlon optimised kernel places pretty much the absolute maximum load

possible on the memory bus. Several people have reported that machines
that
are otherwise stable on the bios fast options require  the proper
conservative
settings to be stable with the Athlon optimisations

Alan

