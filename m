Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262066AbSIPPC0>; Mon, 16 Sep 2002 11:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbSIPPC0>; Mon, 16 Sep 2002 11:02:26 -0400
Received: from 62-190-201-140.pdu.pipex.net ([62.190.201.140]:54788 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262066AbSIPPCZ>; Mon, 16 Sep 2002 11:02:25 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209161514.g8GFEjL0000740@darkstar.example.net>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
To: landley@trommello.org (Rob Landley)
Date: Mon, 16 Sep 2002 16:14:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209161444.g8GEhw2f017462@pimout1-ext.prodigy.net> from "Rob Landley" at Sep 16, 2002 05:43:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Talking about dumping oopsen, would there be any usefulness in outputting
> > crash data to the PC speaker, using a slow, (~300 bps) modulation that
> > would survive being captured on a cassette using a walkman with a
> > microphone, then decoded using a userspace program from a sampled .au file?
> 
> This is easier and less error-prone than copying the oops down by hand?

Well, it is easy to make a mistake writing it down...

> I remember using 300 bps.  On a closed electrical circuit without acoustic 
> couplers, you still got line noise.  Acoustic couplers put the speaker and 
> microphone right on top of each other and surrounded them with a muffler to 
> try to minimize ambient noise from the room...

WHAT?  I have captured 1200/75 'prestel' style modem communications on tape, and played them back through a speaker, in to a phone handset, and had them faithfully reproduced on a terminal.  Having said that, trying to use a 300 bps accustic coupler with a GSM phone wasn't successful, because you get some kind of inductive interference from the phone.

> > Just thought it might be easily implementable, as it doesn't have any
> > pre-requisits, (other than having a PC speaker, which *almost* everybody
> > has).
> 
> Not everybody has a tape recorder, though.
> 
> And the -ac branch already does output in morse code.  Try taping that and 
> writing a user mode interpreter for it, if you like...

Hmmm, that might be worth doing, because it gives you a way to automatically recover the data, rather than typing it in again, (which is prone to errors).

John.
