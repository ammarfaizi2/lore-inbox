Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267795AbRGQIcY>; Tue, 17 Jul 2001 04:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267796AbRGQIcN>; Tue, 17 Jul 2001 04:32:13 -0400
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:31910 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S267795AbRGQIb6>; Tue, 17 Jul 2001 04:31:58 -0400
Date: Tue, 17 Jul 2001 04:31:53 -0400 (EDT)
From: "Mike A. Harris" <mharris@redhat.com>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Jeff Hartmann <jhartmann@valinux.com>, John Cavan <johnc@damncats.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <995312089.987.8.camel@nomade>
Message-ID: <Pine.LNX.4.33.0107170323450.1440-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jul 2001, Xavier Bestel wrote:

>Date: 16 Jul 2001 21:34:48 +0200
>From: Xavier Bestel <xavier.bestel@free.fr>
>To: Jeff Hartmann <jhartmann@valinux.com>
>Cc: John Cavan <johnc@damncats.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
>     linux-kernel@vger.kernel.org
>Content-Type: text/plain
>Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
>
>On 16 Jul 2001 13:32:10 -0600, Jeff Hartmann wrote:
>
>> > Would it not be a bit more robust to have a wrapper module that pulls in
>> > the correct one on demand? In other words, for the radeon, you would
>> > still have the radeon.o module, but it would determine which child
>> > module to load depending on the version of X that is requesting it. Thus
>> > XFree86 would not require any changes and the backwards compatibility
>> > would be maintained invisibly.
>> >
>> > John
>> >
>> No, because the 2D ddx module is the one doing all the versioning.  It
>> doesn't tell the kernel its version number etc., but the ddx module gets
>> the version from the kernel, and fails if its the wrong one.  If the
>> kernel was the one doing the checking, then your suggestiong would be a
>> nice way of handling it.
>
>Well ... you're gonna change the API anyway, so you could add that in
>the protocol.
>Still, I'm a bit disappointed with this ever-changing API. A bit
>un-linux if you ask me.

I'm disappointed only due to the problems it creates maintaining
RPM packages and multiple releases, and such.  Also the confusion
and problems it creates the end user.

One must also understand that XFree86 is not just for Linux.
Their release cycles are not timed for Linux kernel releases or
any distribution of Linux release.  XFree86 is on their own
schedule, and support numerous operating systems on many hardware
platforms.  So XFree86 by default is not linux centric
necessarily, but rather supports Linux as one of many platforms,
Linux just being one of the primary platforms.

The guys at VA certainly know their stuff, and I have total faith
in them.  (Lame pun not intended Rik...)  ;o)

I believe we will see a more stable DRM future now that this has
all been brought up.

TTYL

----------------------------------------------------------------------
Mike A. Harris                  Shipping/mailing address:
OS Systems Engineer             190 Pittsburgh Ave., Sault Ste. Marie,
XFree86 maintainer		Ontario, Canada, P6C 5B3
Red Hat Inc.                    Phone: (705)949-2136
http://www.redhat.com		ftp://people.redhat.com/mharris
----------------------------------------------------------------------

