Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131044AbQLCTXz>; Sun, 3 Dec 2000 14:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131059AbQLCTXq>; Sun, 3 Dec 2000 14:23:46 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1394 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131044AbQLCTXk>; Sun, 3 Dec 2000 14:23:40 -0500
Date: Sun, 3 Dec 2000 12:52:57 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Igmar Palsenberg <maillist@chello.nl>
cc: David Ford <david@linux.com>, Matthew Kirkwood <matthew@hairy.beasts.org>,
        folkert@vanheusden.com, "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <Pine.LNX.4.21.0012031721530.13254-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.3.96.1001203125046.3925A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Igmar Palsenberg wrote:
> > Any programmer who has evolved sufficiently from a scriptie should take
> > necessary precautions to check how much data was transferred.  Those who
> > don't..well, there is still tomorrow.
> > 
> > There is no reason to add any additional documentation.  If we did, we'd be
> > starting the trend of documenting the direction a mouse moves when it's
> > pushed and not to be alarmed if you turn the mouse sideways and the result is
> > 90 degrees off.
> 
> random devices are different. If it request 10 bytes on random stuff, I
> want 10 bytes. Anything less is a waste of the read, because I need 10
> bytes.
> 
> At least, in my opinion.
> 
> Anyone has an insight how other *NIX'es handle this ?

This is standard stuff...  You are really pissing into the wind here ;)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
