Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131660AbRBQNkH>; Sat, 17 Feb 2001 08:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131715AbRBQNj5>; Sat, 17 Feb 2001 08:39:57 -0500
Received: from [194.213.32.137] ([194.213.32.137]:14596 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131660AbRBQNjk>;
	Sat, 17 Feb 2001 08:39:40 -0500
Message-ID: <20010214125357.E1931@bug.ucw.cz>
Date: Wed, 14 Feb 2001 12:53:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Sutherland <jas88@cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14SRPp-0008J1-00@the-village.bc.nu> <3A886F73.759DB067@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A886F73.759DB067@transmeta.com>; from H. Peter Anvin on Mon, Feb 12, 2001 at 03:19:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is true, but one thing I'd really like to have is controlled buffer
> > > overrun, which TCP *doesn't* have.  I really think an ad hoc UDP protocol
> > > (I've already begun sketching on the details) is more appropriate in this
> > > particular case.
> > 
> > Explain 'controlled buffer overrun'. BTW if you make it UDP please include
> > something like SHA hash or tea hash and shared secret
> > 
> 
> I *REALLY* don't know if that is reasonable; it may have to fall into the
> category of "supported but not required".  Requiring an SHA hash in a
> small bootstrap loader may not exactly be a reasonable expectation! 
> However, I think the protocol is inherently going to be asymmetric, with
> as much as possible unloaded.

Being able to remotely resed machine with crashed userland would be
*very* nice, too...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
