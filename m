Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbUC3BiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbUC3BiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:38:05 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8858 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263450AbUC3BdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:33:10 -0500
Date: Tue, 30 Mar 2004 03:33:02 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] silence nfs mount messages
Message-ID: <20040330013300.GC17179@apps.cwi.nl>
References: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl> <1080587480.2410.61.camel@lade.trondhjem.org> <20040329195435.GA19426@apps.cwi.nl> <1080602653.2410.192.camel@lade.trondhjem.org> <20040329234643.GB17179@apps.cwi.nl> <1080606053.2410.260.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080606053.2410.260.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 07:20:53PM -0500, Trond Myklebust wrote:

> The changes you are complaining about have *NOTHING* whatsoever to do

Wait. It seems you think I am complaining about changes. I am not.

I am complaining about kernel messages.
They have been there since 0.99. Hardly changes, but they are annoying.
Mount has to go through all kinds of contortions to avoid these messages.
Has an explicit list of kernel versions built-in.
Yecch.

These messages should have been silenced ten years ago.
People complain.

> > Mount tries the latest version it knows about, when that fails
> > goes back to an earlier version until either the mount succeeds
> > or we give up. The same binary must work over a large range of
> > kernel versions.
> 
> That will break functionality for the user, and sounds like a bug in
> "mount". See my objection w.r.t. the user who thinks he is getting
> secure authentication via RPCSEC_GSS.

If the user installs some distribution, like RedHat or SuSE,
then hopefully the distribution authors know what they are doing.
If the user invents his own system, hopefully he knows what he
is doing. A few random messages hardly improve matters here.
That is what I meant when I mentioned "policy".

And again - if the user asks for "mount -t nfs" she gets an
nfs mount. If you say that she might wish some particular kind
of nfs mount instead of just any, then she should have said so -
by adding some mount option, or by using a different filesystem type.


Andries
