Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282481AbRLOK6v>; Sat, 15 Dec 2001 05:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLOK6l>; Sat, 15 Dec 2001 05:58:41 -0500
Received: from ns.caldera.de ([212.34.180.1]:58080 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S282481AbRLOK62>;
	Sat, 15 Dec 2001 05:58:28 -0500
Date: Sat, 15 Dec 2001 11:58:00 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Andrew Clausen <clausen@gnu.org>
Cc: Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: gendisk list access (was: [Evms-devel] Unresolved symbols)
Message-ID: <20011215115800.D6187@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andrew Clausen <clausen@gnu.org>, Kevin Corry <corryk@us.ibm.com>,
	evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <OFCE7B6713.9A6E1AF1-ON85256B02.004FB1C4@raleigh.ibm.com> <20011112173217.A3404@caldera.de> <01120514525902.13647@boiler> <20011205225346.A7313@caldera.de> <20011211233618.B982@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211233618.B982@gnu.org>; from clausen@gnu.org on Tue, Dec 11, 2001 at 11:36:18PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 11:36:18PM +1100, Andrew Clausen wrote:
> On Wed, Dec 05, 2001 at 10:53:46PM +0100, Christoph Hellwig wrote:
> >  - each block queue gets a pointer to be used for partitioning, this will
> >    be opaque to the drivers.
> 
> Yuck!
> 
> Why do you want a reference to partitions?

I don't want - that't the point.
The whole block layer and the drivers should not know at all about
specific partitions and volume managers.

If we want to still support the current partition APIs it will not
be entirely possible to reach this goal, but Al convienced me in a
long discussion that 2.6 is to early to get rid of those yet.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
