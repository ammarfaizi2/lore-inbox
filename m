Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSIPTud>; Mon, 16 Sep 2002 15:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSIPTud>; Mon, 16 Sep 2002 15:50:33 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:8646 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262804AbSIPTub>;
	Mon, 16 Sep 2002 15:50:31 -0400
Date: Mon, 16 Sep 2002 21:55:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rob Landley <landley@trommello.org>
Cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
Message-ID: <20020916215522.B60197@ucw.cz>
References: <200209161239.g8GCdpgO001846@darkstar.example.net> <200209161444.g8GEhw2f017462@pimout1-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209161444.g8GEhw2f017462@pimout1-ext.prodigy.net>; from landley@trommello.org on Mon, Sep 16, 2002 at 05:43:50AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 05:43:50AM -0400, Rob Landley wrote:
> On Monday 16 September 2002 08:39 am, jbradford@dial.pipex.com wrote:
> > Talking about dumping oopsen, would there be any usefulness in outputting
> > crash data to the PC speaker, using a slow, (~300 bps) modulation that
> > would survive being captured on a cassette using a walkman with a
> > microphone, then decoded using a userspace program from a sampled .au file?
> 
> This is easier and less error-prone than copying the oops down by hand?

Works in X. Hand copying doesn't. But serial (or printer) console is
probably easier.

> I remember using 300 bps.  On a closed electrical circuit without acoustic 
> couplers, you still got line noise.  Acoustic couplers put the speaker and 
> microphone right on top of each other and surrounded them with a muffler to 
> try to minimize ambient noise from the room...

Well, this is simplex only, so it's a bit easier. And we could use even
slower speed, 75 bps would also work.

> > Just thought it might be easily implementable, as it doesn't have any
> > pre-requisits, (other than having a PC speaker, which *almost* everybody
> > has).
> 
> Not everybody has a tape recorder, though.
> 
> And the -ac branch already does output in morse code.  Try taping that and 
> writing a user mode interpreter for it, if you like...

-- 
Vojtech Pavlik
SuSE Labs
