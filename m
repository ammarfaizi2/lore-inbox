Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTJ0Rk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTJ0Rk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:40:57 -0500
Received: from viefep13-int.chello.at ([213.46.255.15]:42284 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S263441AbTJ0Rk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:40:56 -0500
From: Simon Roscic <simon.roscic@chello.at>
To: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>
Subject: Re: [2.6.0-test8/9] ethertap oops
Date: Mon, 27 Oct 2003 18:40:53 +0100
User-Agent: KMail/1.5.4
References: <L1fo.3gb.9@gated-at.bofh.it> <20031026234828.2cb1f746.davem@redhat.com> <20031027122635.GB16013@wotan.suse.de>
In-Reply-To: <20031027122635.GB16013@wotan.suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310271840.53980.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 27. Oct 2003 13:26, Andi Kleen wrote:
> On Sun, Oct 26, 2003 at 11:48:28PM -0800, David S. Miller wrote:
> > On Sun, 26 Oct 2003 23:45:52 +0100
> >
> > Andi Kleen <ak@muc.de> wrote:
> > > diff -u linux-2.6.0test7mm1-averell/drivers/net/ethertap.c-o
> > > linux-2.6.0test7mm1-averell/drivers/net/ethertap.c ---
> > > linux-2.6.0test7mm1-averell/drivers/net/ethertap.c-o	2003-09-11
> > > 04:12:33.000000000 +0200 +++
> > > linux-2.6.0test7mm1-averell/drivers/net/ethertap.c	2003-10-26
> > > 23:41:17.000000000 +0100
> >
> > This part looks good, applied.
>
> I don't know if it actually fixed the bug, I did not test it
> (sorry, should have stated that in the original mail)
> But at least it should printk now instead of crashing.
>
> -Andi

Hi Andi,

Your patch fixed the bug!  Thanks a lot!
I applyed the first hunk as David wrote above.

bye,
        simon.

