Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUBYNWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUBYNWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:22:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60800 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261317AbUBYNWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:22:42 -0500
Date: Wed, 25 Feb 2004 08:23:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Rik van Riel <riel@redhat.com>
cc: Grigor Gatchev <grigor@zadnik.org>, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <Pine.LNX.4.44.0402250751140.30721-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0402250813120.7525@chaos>
References: <Pine.LNX.4.44.0402250751140.30721-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Rik van Riel wrote:

> On Wed, 25 Feb 2004, Grigor Gatchev wrote:
>
> > > I'm all for cleaning up the badly written code so it fits
> > > in better with the rest of the kernel ;)
> >
> > Unhappily, cleaning up would not be enough. A separation of the kernel
> > layers, to the extent that one may be able to use them independently,
> > and to plug modules between them (having the appropriate access) may be
> > better.
>
> Some parts of the kernel (eg. the VFS or the device driver
> layers) can already do that, while others still have layering
> violations.
>
> I suspect that the least destabilising way of moving to a
> more modular model would be to gradually clean up the layering
> violations in the rest of the code, until things are modular.
>
> Yes, I know it's a lot of work ...

But the idea that the kernel should exist as a kind of onion,
depicted by child college professors in their children's coloring
books is wrong. The optimum operating system will always be the
one that performs its functions in the most expedient way, not
the one that is the "prettiest" or easiest to understand. There
can't be any such thing as a "layering violation".

Layering is wrong. However modularizing, although it may
have some negative effects, has many redeeming values. It
allows for the removal of dead code, code that will never
function in a particular system.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


