Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266754AbUFYPL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266754AbUFYPL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUFYPL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:11:26 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:2613 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266754AbUFYPLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:11:24 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6] Altix serial driver
Date: Fri, 25 Jun 2004 11:10:07 -0400
User-Agent: KMail/1.6.2
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org>
In-Reply-To: <20040625083130.GA26557@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406251110.07383.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 25, 2004 4:31 am, Christoph Hellwig wrote:
> On Thu, Jun 24, 2004 at 10:15:41PM -0500, Erik Jacobson wrote:
> > Andrew and LKML folks -
> >
> > Pat is on vacation and said he wouldn't mind if I posted the latest
> > version of this patch.
> >
> >  - I fixed up Kconfig (x86 problem)
> >  - I changed SYSFS_ONLY to USE_DYNAMIC_MINOR
>
> Please kill the ifdef completely.  As long as LANANA hasn't responded you
> should only use the dyanic nimor, and once it's accepted there's no point
> in using the dynamico ne anymore.  Also I'd sugges grabbing a whole dyanmic
> major instead of using a miscdevice so the code both cases is more similar.

But LANANA doesn't assign minors, right?  And Linus hasn't banned those, so 
the patch to devices.txt should be sufficient, right?  (Please let the answer 
be yes!)  Moreover, isn't this Andrew's decision as the 2.6 maintainer?

Thanks,
Jesse
