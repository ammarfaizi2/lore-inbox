Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLNXxC>; Thu, 14 Dec 2000 18:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbQLNXww>; Thu, 14 Dec 2000 18:52:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18948 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129423AbQLNXwl>; Thu, 14 Dec 2000 18:52:41 -0500
Subject: Re: Signal 11
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 14 Dec 2000 23:24:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012141434320.12451-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 14, 2000 02:45:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146hjU-0000E4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you ask any gcc folks, the main reason they think this was a really
> stupid thing to do was exactly that the 2.96 thing is incompatible BOTH
> with the 2.95.x release _and_ the upcoming 3.0 release.

And with egcs 1.1.2. So 
	egcs is a different format to all others
	2.95 is a different format to all others
	2.96 is a different format to all others

and 2.96 is a C++ compiler

> gcc-2.95.2 is at least a real release, from a branch that is actively
> maintained - so a 2.95.3 is likely to happen reasonably soon, fixing as
> many problems as possible _without_ being incompatible like the snapshots
> are.

The 2.96 tree is maintained actively. Updates for the Red Hat 7 packages
are being worked on and CygnusHat people are working on both that maintenance
and on feeding all they find back to the core gcc team.

In fact we have sufficient faith in it we sell packages and support based around
that and our preparedness to support it. 

> As to X compile problems - neither egcs nor 2.95.2 appears to have any
> trouble with the CVS tree. Possibly because they got fixed, because, after
> all, at least those were real releases.

I asked Jakub. He's confused as to your report. As far as he is aware the only
X problems in the CVS tree were related to XFree86 source code bugs misusing
type punning. If you have a case to lookat Jakub would love to hear about it
and fix either X or gcc.

> I'd applaud RedHat for making snapshots available, but they should be
> marked as SNAPSHOTS, and not as the main compiler with no way to fix the
> damn problems it causes.

That it was confusing and mistaken by some as an official GNU group release
is something we never intended and have already apologised for. It was done
without malice or ill intent.

> As it is, anybody doing development is probably better off at RH-6.2.
> That is doubly true if they intend to release binaries.

We strongly recommend that people use 6.2 for developing binaries for general
release unless they have specific requirements for glibc 2.2. Thats the same
guidelines the LSB 'oops we havent finished yet here is a quickie for now'
documentation recommends.

Similarly RPM packaging using RPMv3 is recommended.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
