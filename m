Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTAYRgy>; Sat, 25 Jan 2003 12:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTAYRgy>; Sat, 25 Jan 2003 12:36:54 -0500
Received: from [81.2.122.30] ([81.2.122.30]:11014 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261594AbTAYRgx>;
	Sat, 25 Jan 2003 12:36:53 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301251746.h0PHkZax001209@darkstar.example.net>
Subject: Re: [Corrected] Set2 scancodes for Japanese keyboard
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sat, 25 Jan 2003 17:46:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030125184046.A16824@ucw.cz> from "Vojtech Pavlik" at Jan 25, 2003 06:40:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > What kernel this is tested with? What method used? These don't look like
> > > Set2 codes AT ALL.
> > 
> > The kernel is 2.4.20.  The keycode is the output from showkey, and the
> > make and break codes are the output from showkey -s.
> > 
> > Should I have used I8042_DEBUG_IO instead?  :-/
> 
> With 2.5, yes, that'd be much better. And yet better it'd be if you'd
> have used the "i8042_direct=1" kernel option, and for set3 the
> "atkbd_set=3" option.
> 
> I'm sorry to tell you after you wrote it all down, but these are set1
> scancodes you see.

I should have realised anyway - I remember now it translates
everything to set 1.

Oh dear, well, it might take a while - I packed my serial terminal
away yesterday, because a wire needs to be soldered on it :-), (which
explains why I was writing it all down :-) )

John.
