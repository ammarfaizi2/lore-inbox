Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVIEDGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVIEDGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVIEDGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:06:32 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:64460 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932123AbVIEDGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:06:32 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Date: Mon, 5 Sep 2005 13:08:20 +1000
User-Agent: KMail/1.8.2
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050904203755.GA25856@us.ibm.com>
In-Reply-To: <20050904203755.GA25856@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051308.20331.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005 06:37 am, Nishanth Aravamudan wrote:
> On 04.09.2005 [21:26:16 +0100], Russell King wrote:
> > On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > > I've got a few ideas that I think might help push Con's patch
> > > coalescing efforts in an arch-independent fashion.

Thanks very much Nish!

I've updated the patches here http://ck.kolivas.org/patches/dyn-ticks/ with 
the latest change to timer_pm.c that Srivatsa sent me and have a new rollup 
there as well as the split out patches. The ball is in Nish's court now so 
we'll avoid touching the code till you get back to us (this project needs 
some form of locking ;) ).

Cheers,
Con
