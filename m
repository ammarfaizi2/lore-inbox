Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293400AbSCSXLM>; Tue, 19 Mar 2002 18:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310295AbSCSXLE>; Tue, 19 Mar 2002 18:11:04 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:37583 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S293400AbSCSXKu>;
	Tue, 19 Mar 2002 18:10:50 -0500
Date: Wed, 20 Mar 2002 00:10:48 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Mark <mark@bish.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: C-Media 8738 sound driver + A7M266-D problems.
In-Reply-To: <Pine.LNX.4.43.0203182216260.32113-100000@bish.net>
Message-ID: <Pine.LNX.4.44.0203192356110.3402-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Mar 2002, Mark wrote:
> I have a dual AMD board that has the 8738 onboard.  I compile 2.4.18 and
> pass it the '6 speaker' selection which should push the Rear speaker
> signal out the Line In connector and the Center Speaker Out/ Sub-woofer
> signal out the Mic In connector.  This does not happen.  I've tried this
> as a module and passing the params on the command line as well as
> compiling it directly into the kernel.  Am I missing something (very
> likely) or is this a known situation that I just have to deal with?

Are you sure your hardware supports 6-channel output? There are
several version of the 8738 chip (with/without spdif, 4/6 channel).
The chip should read something like "CMI8738/PCI-6CH".

Furthermore, it requires some extra hardware (analog multiplexers, for
example a 4053) to switch the connections. Maybe the manufacturer
left that out (to save a few cents).

Eric

