Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263086AbRFFNl7>; Wed, 6 Jun 2001 09:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbRFFNlt>; Wed, 6 Jun 2001 09:41:49 -0400
Received: from ns.caldera.de ([212.34.180.1]:50101 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263086AbRFFNlc>;
	Wed, 6 Jun 2001 09:41:32 -0400
Date: Wed, 6 Jun 2001 15:40:50 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: t.sailer@alumni.ethz.ch
Cc: Christoph Hellwig <hch@ns.caldera.de>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
Message-ID: <20010606154050.A6245@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, t.sailer@alumni.ethz.ch,
	Christoph Hellwig <hch@ns.caldera.de>,
	Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200106061051.f56App623652@ns.caldera.de> <3B1E16EB.9FEA94CA@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1E16EB.9FEA94CA@scs.ch>; from sailer@scs.ch on Wed, Jun 06, 2001 at 01:41:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 01:41:31PM +0200, Thomas Sailer wrote:
> Christoph Hellwig schrieb:
> > 
> > In article <20010605234928.A28971@lightning.swansea.linux.org.uk> you wrote:
> > > 2.4.5-ac9
> > 
> > > o     Add es1371 sound driver locking                 (Frank Davis)
> > 
> > It's buggy.  The locking in ->read and ->write will give
> > double ups when a signal is pending and remove a not added waitq
> > when programming the dmabuf fails.
> 
> But Alan added a different patch than yours,

Mine got _that_ right.

> that doesn't seem to have poll in the guard.
> 
> Also, both your and Frank Davis' patch don't care about dac, which
> seems bogus to me.

Yepp.

-- 
Of course it doesn't work. We've performed a software upgrade.
