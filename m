Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbRAYMR3>; Thu, 25 Jan 2001 07:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRAYMRT>; Thu, 25 Jan 2001 07:17:19 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:12533 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130378AbRAYMRJ>; Thu, 25 Jan 2001 07:17:09 -0500
Date: Thu, 25 Jan 2001 12:17:06 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
In-Reply-To: <20010125115827.A1483@emma1.emma.line.org>
Message-ID: <Pine.SOL.4.21.0101251216070.651-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Matthias Andree wrote:

> On Wed, 24 Jan 2001, Andi Kleen wrote:
> 
> > It's mostly for security to make it more difficult to nuke connections
> > without knowing the sequence number.
> > 
> > Remember RFC is from a very different internet with much less DoS attacks.
> 
> If you're deliberately breaking compatibility by violating the specs,
> you're making your own DoS if your machines can't chat to each other. If
> you insist on breaking the RFC, make a sysctl for this behaviour that
> defaults to "off".

This isn't a violation - the section quoted does not REQUIRE the
behaviour, it only RECOMMENDS it as being a good idea. Since implementing
it apparently makes DoS attacks easier, NOT implementing it is now a
better idea...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
