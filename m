Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267719AbTASXWP>; Sun, 19 Jan 2003 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbTASXWP>; Sun, 19 Jan 2003 18:22:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13330
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267719AbTASXWO>; Sun, 19 Jan 2003 18:22:14 -0500
Date: Sun, 19 Jan 2003 15:27:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bryan Andersen <bryan@bogonomicon.net>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
In-Reply-To: <3E2B239E.40308@bogonomicon.net>
Message-ID: <Pine.LNX.4.10.10301191521020.12087-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One thing to ask, did you get an 0x51 , 0x04 error set prior to seeing the
flush cache message error?

If not then those changes need to be stripped out as more proof of letting
the device protect itself from properly formed commands.

The change to hid one noise maker pollutes another wrongly.



On Sun, 19 Jan 2003, Bryan Andersen wrote:

> To me they seam like a candidate for output at a higher
> debug level or ide specific debug.  They aren't a driver
> setup, odd condition, or error message.
> 
> - Bryan
> 
> Tupshin Harper wrote:
> > Andre Hedrick wrote:
> > 
> >> Exactly when you want to flush the devices to platter.
> >> The problem will be what to do if we get an error on flush-cache.
> >>
> > Are these "no cach flush required" messages going to be removed? It does 
> > clutter up the boot process output pretty badly.
> 

Andre Hedrick
LAD Storage Consulting Group

