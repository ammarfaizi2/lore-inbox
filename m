Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSHGBeh>; Tue, 6 Aug 2002 21:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSHGBeh>; Tue, 6 Aug 2002 21:34:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17285 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316615AbSHGBeg>; Tue, 6 Aug 2002 21:34:36 -0400
Date: Tue, 6 Aug 2002 21:42:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tim Hockin <thockin@hockin.org>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
Subject: Re: ethtool documentation
In-Reply-To: <200208062115.g76LFga14394@www.hockin.org>
Message-ID: <Pine.LNX.3.95.1020806213513.26349A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Tim Hockin wrote:

> > If you ever sell a controller that contains an address that was
> > not allocated to the 'producer', somebody is going to get very
> > angry. This means, to me, that if you ever write a new MAC address
> > to that card/board, you had better throw it away when you are done.
> 
> As a developer of integrated systems, it is imperative the we be able to
> re-program EEPROMs and MAC addresses.  Cobalt systems all have Cobalt as
> the MFR section of the MAC address.  Sun Systems all have Sun.  (insert pokes
> about whether Cobalt is Sun here...)
> 
> > It's easier to make sure that the MAC address doesn't get changed.
> > You still "screw the comittee" locally, but you don't modify the
> > hardware.
> 
> Other things get stored in the EEPROM - for example, Wake-on-Lan options.
> Just to name one.
> 
If you really are what you say you are, then you know that you
cannot use a MAC address that has not been assigned to your
company.

And, as a developer or "integrated systems", I do program MAC
addresses into AMD PCnet32 SEEPROMS and I do have a batch of
MAC addresses assigned to Analogic and I do known what I am
talking about.

The Linux pcnet32 driver does not have this capability so I
had to add that capability for our purposes. I would not
advise putting such a driver in the standard kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

