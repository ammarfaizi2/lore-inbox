Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318258AbSGQJ7n>; Wed, 17 Jul 2002 05:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318261AbSGQJ7m>; Wed, 17 Jul 2002 05:59:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46070 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318258AbSGQJ7h>; Wed, 17 Jul 2002 05:59:37 -0400
Subject: Re: Ali5451 and MIDI synth
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neale Banks <neale@lowendale.com.au>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10207171759430.2212-100000@marina.lowendale.com.au>
References: <Pine.LNX.4.05.10207171759430.2212-100000@marina.lowendale.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 12:12:35 +0100
Message-Id: <1026904355.2119.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 09:04, Neale Banks wrote:
> On 17 Jul 2002, Alan Cox wrote:
> 
> > On Wed, 2002-07-17 at 03:51, Neale Banks wrote:
> > > * linux-2.2 has MIDI support in the code (v0.14.5c of trident.c) - but
> > > this driver (a) doesn't work for basic audio[1] and (b) doesn't register a
> > > MIDI synth device (and MIDI players complain of no device).
> > 
> > ALSA supports the synth facilities of the device, but not as "midi". The
> > trident synth doesn't talk midi.
> 
> Pardon the naive question, but does that mean that apps looking for
> (IIRC) /dev/sequencer are going to be workable with this chip or not?
 
The old /dev/sequencer stuff died with ISA bus midi synths. None of the
PCI sound drivers support it.

