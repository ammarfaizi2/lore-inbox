Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143969AbRA1TmS>; Sun, 28 Jan 2001 14:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143939AbRA1TmI>; Sun, 28 Jan 2001 14:42:08 -0500
Received: from [63.95.87.168] ([63.95.87.168]:26636 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S143931AbRA1TmF>;
	Sun, 28 Jan 2001 14:42:05 -0500
Date: Sun, 28 Jan 2001 14:42:04 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: James Sutherland <jas88@cam.ac.uk>
Cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010128144204.B13195@xi.linuxpower.cx>
In-Reply-To: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca> <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sun, Jan 28, 2001 at 01:29:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 01:29:52PM +0000, James Sutherland wrote:
> > There is nothing silly with the decision, davem is simply a modern day
> > internet hero.
> 
> No. If it were something essential, perhaps, but it's just a minor
> performance tweak to cut packet loss over congested links. It's not
> IPv6. It's not PMTU. It's not even very useful right now!

No. ECN is essential to the continued stability of the Internet. Without
probabilistic queuing (i.e. RED) and ECN the Internet will continue to have
retransmit synchronization and once congested stay congested until people get
frustrated and give it up for a little bit.

It's a real issue, and it's actually important to have it implemented. It's
not just a performance hack.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
