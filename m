Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130676AbRBMIqo>; Tue, 13 Feb 2001 03:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130906AbRBMIqf>; Tue, 13 Feb 2001 03:46:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:15882 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130676AbRBMIqX>; Tue, 13 Feb 2001 03:46:23 -0500
Date: Tue, 13 Feb 2001 03:46:18 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Mike Harrold <mharrold@cas.org>
cc: David Woodhouse <dwmw2@infradead.org>,
        Guest section DW <dwguest@win.tue.nl>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: lkml subject line
In-Reply-To: <200102121525.KAA16906@mah21awu.cas.org>
Message-ID: <Pine.LNX.4.33.0102130341580.1123-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Mike Harrold wrote:

>> >  There are advantages: distinguish personal messages from mailing list
>> > messages, and distinguish between different mailing lists. And
>> > disadvantages - maybe only one: sacrificing valuable Subject: line
>> > space.
>>
>> The advantages can all be gained without that disadvantage by just learning
>> to filter mail on other headers instead of the subject line.
>
>Assuming your mail reader can do that (and no, I can't change my mail
>reader).

You can use procmail to filter your mail VERY easily.  Penalizing
an entire list of 7000 people or more just because 3 people can't
use a sane modern mail reader is just senseless.

This filters linux-kernel into the folder LINUX-KERNEL

cat >> ~/.procmailrc <<EOF
:0:
* ^X-Mailing-List:.*linux-kernel@vger.kernel.org
* ^Sender:.*linux-kernel-owner@vger
LINUX-KERNEL

EOF

That said, and while we're on the topic.. Does anyone have a
*PERFECT* recipe for procmail to REMOVE the stupid [Dummy] things
most GNU mailman lists and others prepend to the subject?

xpert@xfree86.org is one such list and I have given up on
complaining to list maintainers of other lists to change this,
and would rather fix it on my end once than complain to others.

I asked on procmail-list and got some feedback but it didn't give
me a useable filter..

Any help appreciated..
TTYL

----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
If it weren't for C, we'd all be programming in BASI and OBOL.

