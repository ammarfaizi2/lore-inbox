Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbUADWR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUADWR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:17:28 -0500
Received: from [193.138.115.2] ([193.138.115.2]:16904 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265179AbUADWRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:17:25 -0500
Date: Sun, 4 Jan 2004 23:14:39 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Tim Cambrant <tim@cambrant.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspected bug in fs/ufs/inode.c - test for < 0 on unsigned se
 ctor_t - [2.6.1-rc1-mm1]
In-Reply-To: <20040104125714.GA24157@cambrant.com>
Message-ID: <Pine.LNX.4.56.0401042310560.5550@jju_lnx.backbone.dif.dk>
References: <20040104125714.GA24157@cambrant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Tim Cambrant wrote:

> On Sat, Jan 03, 2004 at 11:45:56PM +0100, Jesper Juhl wrote:
> >
> > Is this analysis correct?  If it is, can the code simply be removed?
>
> It does seem odd, but indeed, a confirmation from someone with authority
> would be nice before digging in to a cleanup-process like this. Try
> e-mailing
> the maintainer of the code directly, since it doesn't seem like anyone
> feels like wasting any time on this :)
>
I'm glad I'm not the only one who thinks this is odd. I'll try
emailing the maintainers of the filesystems directly and see what response
I get.


> Nice job on the discovery though,

Thank you.


> if this is true, these things really
> should
> be removed.
>
I just want to find out what is actually going on and why that code was
put there in the first place before I start changing/removing anything.
Currently I'm digging on my own but haven't come up with much yet - except
that the same code seems to be used in some other filesystems as well (as
I note in a reply to my initial mail)...
I'll keep digging.


/Jesper Juhl

