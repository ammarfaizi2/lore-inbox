Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWCWNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWCWNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWCWNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:50:16 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:1522 "EHLO
	poseidon.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S1751374AbWCWNuP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:50:15 -0500
From: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
To: Jan Knutar <jk-lkml@sci.fi>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: swap prefetching merge plans
Date: Thu, 23 Mar 2006 14:50:01 +0100
User-Agent: KMail/1.9.1
References: <200603230856.24091.volker.armin.hemmann@tu-clausthal.de> <44225BBF.2040604@yahoo.com.au> <200603231347.51219.jk-lkml@sci.fi>
In-Reply-To: <200603231347.51219.jk-lkml@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603231450.02479.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 12:47, you wrote:
> On Thursday 23 March 2006 10:26, Nick Piggin wrote:
> > Hemmann, Volker Armin wrote:
> > > Hi,
> > >
> > > I am just a user, but I would love to see this feature.
> > >
> > > After compiling stuff, I have usually some kb in swap (300kb, 360 kb),
> > > and lots of free ram. But even this few kb make my KDE desktop extremly
> > > sluggish. It feels, like every byte is fetched individually and always
> > > the wrong stuff ends in swap.
> >
> > I'm almost positive this wouldn't be the cause of your problems (even a
> > slow disk could read all these blocks in, randomly, in under 2 seconds,
> > assuming they're spread from one end of the platters to the other).
>
> Maybe he meant 300 megabytes.

no, I meant kilobytes.

And swapoff really helps.

Some moments of disk activity, and bang, computer is as fast as always again.

But having stuff in swap? konqueror is slow, kmail is slow, opening a konsole 
session, slow. Everything crawls with lots of disk access. 

next time the computer is slow, I could gather some data - if you tell me, 
what is interessting for you, I'll save it.

Glück Auf,
Volker
