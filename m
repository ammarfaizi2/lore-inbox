Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbRBPJc7>; Fri, 16 Feb 2001 04:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129769AbRBPJct>; Fri, 16 Feb 2001 04:32:49 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:16043 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129379AbRBPJcl>; Fri, 16 Feb 2001 04:32:41 -0500
Date: Fri, 16 Feb 2001 09:32:34 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 8139 full duplex?
In-Reply-To: <200102160858.JAA02472@cave.bitwizard.nl>
Message-ID: <Pine.SOL.4.21.0102160930050.26108-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Rogier Wolff wrote:

> 
> Hi All,
> 
> I have a bunch of computers with 8139 cards. When I moved the cables
> over from my hub to my new switch all the "full duplex" lights came on
> immediately.

That's what you would expect: they will auto-negotiate full duplex, in the
same way they would negotiate 10 or 100 Mbit/sec.

> Would this mean that the driver/card already were in full-duplex?

No, that's not possible. They just automatically configured for the
best performance available - in this case, full duplex.

> That would explain me seeing way too many collisions on that old hub
> (which obviously doesn't support full-duplex).

No, it would just prevent your card working. Large numbers of collisions
are normal during fast transfers across a hub.


James.

