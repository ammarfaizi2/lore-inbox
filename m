Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287657AbSAFD1w>; Sat, 5 Jan 2002 22:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287615AbSAFD1m>; Sat, 5 Jan 2002 22:27:42 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4338 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287626AbSAFD1h>;
	Sat, 5 Jan 2002 22:27:37 -0500
Date: Sat, 5 Jan 2002 20:27:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Jason Thomas <jason@topic.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br
Subject: Re: oops in devfs
Message-ID: <20020105202715.N12868@lynx.no>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Jason Thomas <jason@topic.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	marcelo@conectiva.com.br
In-Reply-To: <20020103014507.GB19702@topic.com.au> <200201030724.g037ONj04041@vindaloo.ras.ucalgary.ca> <20020103224744.GB29846@topic.com.au> <200201060047.g060l4p08166@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200201060047.g060l4p08166@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sat, Jan 05, 2002 at 05:47:04PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 05, 2002  17:47 -0700, Richard Gooch wrote:
> Ah! You're using LVM! There are known bugs in LVM which cause memory
> corruptions. I told Heinz about this on 16-DEC, but it appears the CVS
> tree hasn't been updated yet. So grab the latest CVS tree (which fixes
> some bugs) and then apply the appended patch (which fixes more
> bugs). You definately need both. The patch should be applied in the
> drivers/md directory.

Hmm, my understanding was that the LVM CVS already had this patch
applied, but I could be wrong...  In any case, I haven't seen anything
about updating the kernel LVM to match CVS since Alan merged in his
-ac LVM code into 2.4.15 or so.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

