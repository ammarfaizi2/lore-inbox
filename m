Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278684AbRJXR4f>; Wed, 24 Oct 2001 13:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRJXR40>; Wed, 24 Oct 2001 13:56:26 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:61690 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S278684AbRJXR4S>; Wed, 24 Oct 2001 13:56:18 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6A1@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: RE: [RFC] New Driver Model for 2.5
Date: Wed, 24 Oct 2001 10:56:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> I have all of this more or less working on pmac laptops. I don't have
> the new device model, so I handle dependencies manually with 
> a priority
> mecanism, but it's already good enough to let me resume 
> userland before
> ADB and sound, and possibly stuffs. (Which is nice since my 
> sound chips
> usually need one or 2 second to recalibrate and ADB need a 
> few seconds to
> probe the bus, all this happens asynchronously).

Awesome.

So non i386 archs do not have the problem with the video bios having to run
on resume, or did you have to handle this somehow?

Regards -- Andy
