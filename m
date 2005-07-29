Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVG2RD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVG2RD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVG2RD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:03:56 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:16065 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262666AbVG2RDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:03:40 -0400
Date: Fri, 29 Jul 2005 19:03:14 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>,
       Kumar Gala <galak@freescale.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
 maintained
In-Reply-To: <20050727101502.B1114@cox.net>
Message-Id: <Pine.OSF.4.05.10507291900320.26224-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jul 2005, Matt Porter wrote:

> On Wed, Jul 27, 2005 at 09:27:41AM -0700, Eugene Surovegin wrote:
> > On Wed, Jul 27, 2005 at 12:13:23PM -0400, Michael Richardson wrote:
> > > Kumar, I thought that we had some volunteers to take care of some of
> > > those. I know that I still care about ep405, and I'm willing to maintain
> > > the code.
> > 
> > Well, it has been almost two months since Kumar asked about maintenance 
> > for this board. Nothing happened since then.
> > 
> > Why is it not fixed yet? Please, send a patch which fixes it. This is 
> > the _best_ way to keep this board in the tree, not some empty 
> > maintenance _promises_.
> 
> When we recover our history from the linuxppc-2.4/2.5 trees we can
> show exactly how long it's been since anybody touched ep405.
> 
> Quick googling shows that it's been almost 2 years since the last
> mention of ep405 (exluding removal discussions) on linuxppc-embedded.
> Last ep405-related commits are more than 2 years ago.
> 
I don't follow that reasoning. Even broken drivers(board support files,
whateever) are better than non.

Take ArcNet support forinstance. Clearly it hadn't been used in any 2.6
kernel up until around 2.6.10. It was highly broken (call to
uninitialized function pointer). But I needed it. I fixed it and send the
patch so it works from 2.6.11 and up.  If the driver had been dropped in
the 2.6 series because nobody actively maintained it, I  wouldn't have got
around to fix it at all and was probably forced to use another OS for my
perpose.  

But because the driver was still in there and somebody had made sure it
was updated along the changes to the API in the 2.6 kernel, it was easy
for me to fix it although I didn't know so much about the kernel internals
at that time.

Esben





