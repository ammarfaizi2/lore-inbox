Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSAFIcp>; Sun, 6 Jan 2002 03:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSAFIcg>; Sun, 6 Jan 2002 03:32:36 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:11427 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287768AbSAFIcS>; Sun, 6 Jan 2002 03:32:18 -0500
Date: Sun, 6 Jan 2002 01:32:09 -0700
Message-Id: <200201060832.g068W9411534@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Jason Thomas <jason@topic.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br
Subject: Re: oops in devfs
In-Reply-To: <20020105202715.N12868@lynx.no>
In-Reply-To: <20020103014507.GB19702@topic.com.au>
	<200201030724.g037ONj04041@vindaloo.ras.ucalgary.ca>
	<20020103224744.GB29846@topic.com.au>
	<200201060047.g060l4p08166@vindaloo.ras.ucalgary.ca>
	<20020105202715.N12868@lynx.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Jan 05, 2002  17:47 -0700, Richard Gooch wrote:
> > Ah! You're using LVM! There are known bugs in LVM which cause memory
> > corruptions. I told Heinz about this on 16-DEC, but it appears the CVS
> > tree hasn't been updated yet. So grab the latest CVS tree (which fixes
> > some bugs) and then apply the appended patch (which fixes more
> > bugs). You definately need both. The patch should be applied in the
> > drivers/md directory.
> 
> Hmm, my understanding was that the LVM CVS already had this patch
> applied, but I could be wrong...  In any case, I haven't seen
> anything about updating the kernel LVM to match CVS since Alan
> merged in his -ac LVM code into 2.4.15 or so.

When I wrote this message, I had just before downloaded LVM using CVS,
following the instructions at: http://www.sistina.com/products_CVS.htm
AFAIK, that's the most recent version of LVM.

Hm. Andreas: do you have write access?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
