Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWAKJR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWAKJR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWAKJR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:17:27 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:60142 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751388AbWAKJR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:17:26 -0500
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Ric Wheeler <ric@emc.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, arnd@arndb.de,
       linux-kernel@vger.kernel.org,
       "saparnis, carol" <saparnis_carol@emc.com>
In-Reply-To: <43BE7EE4.3010203@emc.com>
References: <20051216143348.GB19541@lst.de> <20060106110157.GA16725@lst.de>
	 <43BE7C45.4090206@emc.com> <20060106142146.GA20094@lst.de>
	 <43BE7EE4.3010203@emc.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 10:16:27 +0100
Message-Id: <1136970987.6147.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 09:29 -0500, Ric Wheeler wrote:
> 
> Christoph Hellwig wrote:
> 
> >>If you could hold off just a couple of weeks, I hope that we can get 
> >>through our EMC process junk and get the GPL'ed patch out to fix the 
> >>symmetrix support part of this rolled in as well,
> >>    
> >>
> >
> >Why?  We never do things to support legally questionable binary modules.
> >And on the practical side, does emc even ship modules for -mm release?
> >What's the point of not putting it into -mm?
> >  
> >
> No need for an EMC module, I think that we can issue a simple  patch to 
> dasd.c that removes the (silly) binary module that was there.
> 
> I would prefer that the clean up not break one of the few (and 
> relatively common) devices supported by the dasd.c driver. If for no 
> other reason, it would seem to make it more likely to be able test the 
> existing patch properly.

The patch we got from EMC is for 2.4 and in its current form would never
have worked for 2.6 anyway. So 2.6 is already broken, no reason to hold
off the ioctl removal patch. We'll come up with a cleaned up solution.

Christoph, please go ahead and push the patch to Andrew. 

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


