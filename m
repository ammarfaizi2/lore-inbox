Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSIPOjN>; Mon, 16 Sep 2002 10:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbSIPOjM>; Mon, 16 Sep 2002 10:39:12 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:7580 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262137AbSIPOjG>; Mon, 16 Sep 2002 10:39:06 -0400
Message-Id: <200209161444.g8GEhw2f017462@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
Date: Mon, 16 Sep 2002 05:43:50 -0400
X-Mailer: KMail [version 1.3.1]
References: <200209161239.g8GCdpgO001846@darkstar.example.net>
In-Reply-To: <200209161239.g8GCdpgO001846@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 08:39 am, jbradford@dial.pipex.com wrote:
> Talking about dumping oopsen, would there be any usefulness in outputting
> crash data to the PC speaker, using a slow, (~300 bps) modulation that
> would survive being captured on a cassette using a walkman with a
> microphone, then decoded using a userspace program from a sampled .au file?

This is easier and less error-prone than copying the oops down by hand?

I remember using 300 bps.  On a closed electrical circuit without acoustic 
couplers, you still got line noise.  Acoustic couplers put the speaker and 
microphone right on top of each other and surrounded them with a muffler to 
try to minimize ambient noise from the room...

> Just thought it might be easily implementable, as it doesn't have any
> pre-requisits, (other than having a PC speaker, which *almost* everybody
> has).

Not everybody has a tape recorder, though.

And the -ac branch already does output in morse code.  Try taping that and 
writing a user mode interpreter for it, if you like...

> John.
