Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbUARBOt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 20:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUARBOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 20:14:49 -0500
Received: from intra.cyclades.com ([64.186.161.6]:29584 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265818AbUARBOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 20:14:48 -0500
Date: Sat, 17 Jan 2004 23:11:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Stephen Smoogen <smoogen@lanl.gov>, linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
In-Reply-To: <2582475408.1074292759@aslan.btc.adaptec.com>
Message-ID: <Pine.LNX.4.58L.0401172303260.32216@logos.cnet>
References: <1074289406.5752.5.camel@smoogen2.lanl.gov>
 <2582475408.1074292759@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Jan 2004, Justin T. Gibbs wrote:

> > Booting problems with aic7xxx with stock kernel 2.4.24.
>
> ...
>
> > Unexpected busfree while idle
> > SEQ 0x01
>
> A problem with similar symptoms was corrected in driver version 6.2.37
> back in August of last year.  Can you try using the latest driver source
> from here:
>
> 	http://people.FreeBSD.org/~gibbs/linux/SRC/
>
> and see if your problem persists?  The aic79xx driver archive at the
> above location includes both the aic7xxx and aic79xx drivers.  If this
> does not resolve your problem there are other debugging options we can
> enable that may aid in tracking down the problem.

Hi Justin,

Stephen informed me privately that aic7xxx_old works for him.

About the aic7xxx update, well, I believe aic7xxx 6.2.36 is pretty stable
(I dont remember seeing any reliable bug report and I also cant find one
in lkml archives) except this one (and a pair of "lockup on initialization
with SMP").

What bugs are you aware of in 2.4's aic7xxx ?


