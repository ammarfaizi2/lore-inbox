Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270026AbUJTItn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270026AbUJTItn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbUJTIra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:47:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:28318 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270026AbUJTIjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:39:12 -0400
Subject: Re: Versioning of tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <41762058.3000304@pobox.com>
References: <1098254970.3223.6.camel@gaston>  <41762058.3000304@pobox.com>
Content-Type: text/plain
Message-Id: <1098261542.6263.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 18:39:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 18:22, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> > Hi Linus !
> > 
> > After you tag a "release" tree in bk, could you bump the version number
> > right away, with eventually some junk in EXTRAVERSION like "-devel" ?
> > 
> > It's quite painful to have a module dir name clash between the "clean"
> > final tree and whatever dev stuff we are testing out of bk ... it's fine
> > once you go to -rc1, but in the meantime, it's really annoying.
> 
> echo "-bk" > localversion
> make
> 
> You can do it just as easily as anyone else :)

Of course I can, and of course I keep forgetting... :) And a bunch of ppl
are apparently having the same problem :) Not even counting a guy this
morning reporting me of "problems with 2.6.9" while he was actually using
the bk top of tree from yesterday night...

But well, it's up to Linus :) I just though it would be convenient ...

Ben.

