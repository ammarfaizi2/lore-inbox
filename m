Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264932AbUEQINN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbUEQINN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 04:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUEQINM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 04:13:12 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:10906 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264932AbUEQINL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 04:13:11 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Mon, 17 May 2004 10:21:05 +0200
User-Agent: KMail/1.5
Cc: andrea@suse.de, torvalds@osdl.org, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <20040516142916.7d07c9f3.akpm@osdl.org> <200405161611.17688.elenstev@mesatop.com>
In-Reply-To: <200405161611.17688.elenstev@mesatop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405171021.05314.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 of May 2004 00:11, Steven Cole wrote:
> On Sunday 16 May 2004 03:29 pm, Andrew Morton wrote:
> > Steven Cole <elenstev@mesatop.com> wrote:
> > > Anyway, although the regression for my particular machine for this
> > >  particular load may be interesting, the good news is that I've seen
> > >  none of the failures which started this whole thread, which are
> > > relatively easily reproduceable with PREEMPT set.
> >
> > So...  would it be correct to say that with CONFIG_PREEMPT, ppp or its
> > underlying driver stack
> >
> > a) screws up the connection and hangs and
> >
> > b) scribbles on pagecache?
> >
> > Because if so, the same will probably happen on SMP.
>
> Perhaps someone has the hardware to test this.

Well, this may be OT (I'm sorry, if so), but I ran pppd yesterday on 2.6.6-mm2 
with no major problems on an SMP box (AMD64).  The only problem I had with it 
is that the pppd died unexpectedly 6-7 minutes after the connection had been 
established, but this might happen for many reasons.  My kernel had been 
built without CONFIG_PREEMPT, though.

