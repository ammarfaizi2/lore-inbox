Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263088AbREWNti>; Wed, 23 May 2001 09:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263087AbREWNt2>; Wed, 23 May 2001 09:49:28 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:3088 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263055AbREWNtP>; Wed, 23 May 2001 09:49:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Wed, 23 May 2001 15:50:21 +0200
X-Mailer: KMail [version 1.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105221851200C.06233@starship> <3B0B3A4C.FD7143F9@gmx.de>
In-Reply-To: <3B0B3A4C.FD7143F9@gmx.de>
MIME-Version: 1.0
Message-Id: <0105231550210J.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 May 2001 06:19, Edgar Toernig wrote:
> IMO the whole idea of arguments following the device name is junk
> (incl a "/ctrl").

You know I didn't suggest that, right?  I find it pretty strange too, but
I'm listening to hear the technical arguments.

> Just think about the implications of the original "/dev/ttyS0/19200"
> suggestion.  It sounds nice and tempting.  But which programs will
> benefit.  Which gets confused.  What will be cleaned up.  After some
> thoughts you'll find out that it's useless ;-)

You know I didn't suggest that either, right?  But I'm with you, I don't
like it at'all, not least because we might change baud rate on the fly.

> And with special "ctrl" devices (ie /dev/ttyS0 and /dev/ttyS0ctrl):
> This _may_ work for some kind of devices.  But serial ports are one
> example where it simply will _not_.  It requires that you know the
> name of the device.  For ttys this is often not the case.
> Even if you manage to get some name for stdin for example - now I 
> should simply attach a "ctrl" to that name to get a control channel???
> At least dangerous.  If I'm lucky I only get an EPERM...

Again, I'll provide a sympathetic ear, but it wasn't my suggestion.

> Ciao, ET.

And you were referring to who?

--
Daniel
