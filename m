Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284778AbRLEWjI>; Wed, 5 Dec 2001 17:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284773AbRLEWi6>; Wed, 5 Dec 2001 17:38:58 -0500
Received: from ns.caldera.de ([212.34.180.1]:40922 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S284778AbRLEWir>;
	Wed, 5 Dec 2001 17:38:47 -0500
Date: Wed, 5 Dec 2001 23:38:29 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: gendisk list access (was: [Evms-devel] Unresolved symbols)
Message-ID: <20011205233829.A11547@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <OFCE7B6713.9A6E1AF1-ON85256B02.004FB1C4@raleigh.ibm.com> <01120514525902.13647@boiler> <20011205225346.A7313@caldera.de> <01120516183303.13647@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01120516183303.13647@boiler>; from corryk@us.ibm.com on Wed, Dec 05, 2001 at 04:18:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 04:18:33PM -0600, Kevin Corry wrote:
> >    a block device and a partition.
> >
> > Hope this helps..
> 
> Sounds good. Any chance you could just leave out the partitioning stuff and 
> let EVMS handle it?

You know my opinion to EVMS - so I'd rather avoid makeing it mandatory.
But if the 2.5 actually looks then like I expect it now partitioning code
will be much simpler than - all code dealing with ondisk formats will
be in early, pre-mount-root userspace, based on Andries Brouwer's partx
(part of util-linux).

> I must have missed your walk_gendisk() patch the last time (do you remember 
> how long ago you posted that?).

It was on Nov, 12 - but it was in a private thread that only started on
evms-devel.  So Mark was the only EVMS person that got it.  Sorry for
the confusion.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
