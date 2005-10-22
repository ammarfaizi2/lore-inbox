Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVJVRii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVJVRii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVJVRih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:38:37 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:7623 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750955AbVJVRih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:38:37 -0400
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally
	attached PHYs)
From: Sergey Panov <sipan@sipan.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051022171943.GA7546@infradead.org>
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com>
	 <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com>
	 <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com>
	 <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>
	 <20051022105815.GB3027@infradead.org>
	 <1129994910.6286.21.camel@sipan.sipan.org>
	 <20051022171943.GA7546@infradead.org>
Content-Type: text/plain
Organization: Home
Date: Sat, 22 Oct 2005 13:38:24 -0400
Message-Id: <1130002704.8775.12.camel@sipan.sipan.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-22 at 18:19 +0100, Christoph Hellwig wrote:
> On Sat, Oct 22, 2005 at 11:28:30AM -0400, Sergey Panov wrote:
> >  It is a mistake to think that you can not do a big rework and keep SCSI
> > sub-system stable. You just have to make sure the OLD way is supported
> > for as log as it is needed.
> 
> No.  Rewriting something from scratch is horrible engineering practice.

Most of the time. Besides "rework" is not necessarily "rewrite from
scratch", most of the time it means "modification" of the existing
system.

> It's impossible to very huge changes, small incremental changes OTOH
> allow easier planning, easier calculation of the risks and cost and most
> import better test coverage.  There's nothing specific to scsi or linux
> kernel code about it.  It'd suggest you read:
> 
>  http://www.joelonsoftware.com/articles/fog0000000069.html

Bad example -- just count number of lines in drivers/scsi/scsi*.c
and in Netscape 4.0 and you'll see why.
That does not mean I advocate throughing out current SCSI mid layer and
writing a new one. As I can tell, no one on that list is proposing the
"rewrite from scratch" approach.
  I just was trying to point out that Luben's transport "layers" in
place of transport "modules-appendages" simplifies that
migration/evolution.   

> or various similar articles.  Full scale rewrites almost never work
> out.


Sergey Panov

===========================================

I expressed my personal opinion and I am not speaking for anyone else.

