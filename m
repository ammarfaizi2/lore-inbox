Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130579AbQK2OrP>; Wed, 29 Nov 2000 09:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131531AbQK2OrF>; Wed, 29 Nov 2000 09:47:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10737 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S130579AbQK2Oq4>;
        Wed, 29 Nov 2000 09:46:56 -0500
Date: Wed, 29 Nov 2000 09:16:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.21.0011291408470.974-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011290913110.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> On Wed, 29 Nov 2000 Andries.Brouwer@cwi.nl wrote:
> 
> > I just tried 2.4.0test12pre3, which has Jens' fix,
> > and no corruption to be seen. Will test a bit more,
> > but perhaps this did it.
> > 
> 
> I have also been testing very hard on the SMP (4xXeon/6G) machine with
> test12-pre3 and also cannot reproduce the problem. This is a SCSI-only
> machine and I don't know what Jens' fix is and whether it is applicable or
> not.

Change in the __make_request() and no, it shouldn't change the behaviour on
SCSI.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
