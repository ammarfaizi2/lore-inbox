Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbSJXNtV>; Thu, 24 Oct 2002 09:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbSJXNtV>; Thu, 24 Oct 2002 09:49:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:11258 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265429AbSJXNtV>;
	Thu, 24 Oct 2002 09:49:21 -0400
Date: Thu, 24 Oct 2002 19:26:59 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Matt D. Robinson" <yakker@aparity.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH] LKCD for 2.5.44 (8/8): dump driver and build files
Message-ID: <20021024192659.A3613@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210230244560.27315-100000@nakedeye.aparity.com> <20021023184020.D16547@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021023184020.D16547@infradead.org>; from hch@infradead.org on Wed, Oct 23, 2002 at 07:58:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 07:58:49PM +0000, Christoph Hellwig wrote:
> > +	}
> 
> You need to call bd_claim to get exclusion on the bdev.
> 

Won't there be a clash when it comes to setting up swap as
the dump device ?

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

