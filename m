Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267760AbTAaLEv>; Fri, 31 Jan 2003 06:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTAaLEv>; Fri, 31 Jan 2003 06:04:51 -0500
Received: from [81.2.122.30] ([81.2.122.30]:34309 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267760AbTAaLEu>;
	Fri, 31 Jan 2003 06:04:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301311112.h0VBCv00000575@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 morse code panics
To: szepe@pinerecords.com (Tomas Szepe)
Date: Fri, 31 Jan 2003 11:12:57 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, arodland@noln.com
In-Reply-To: <20030131104326.GF12286@louise.pinerecords.com> from "Tomas Szepe" at Jan 31, 2003 11:43:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > As this patch further builds upon the previous one,
> > > It'd take a complete change of mind on his part to take
> > > this as it is.
> > 
> > If its attached to atkbd then its not a PCism and its now
> > nicely modularised in the atkbd driver. Providing we have
> > a clear split between the core "morse sender" and the
> > platform specific morse output device (do we want 
> > morse_ops 8)) it should be clean and you can write morse
> > drivers for pc speaker, for non pc keyboard and even for
> > soundblaster 8)

Actually the Soundblaster idea might not be so funny as it originally
sounds, (pun intended :-) ), because if you've got another machine
nearby, with a microphone, you could actually turn up the volume, and
de-code the morse on the other box.  The PC speaker may well be too
quiet to do that.  It should be fairly straightforward to get a simple
bleep out of any card that implements the Adlib registers.

John.
