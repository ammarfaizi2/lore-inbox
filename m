Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263179AbVGAAsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbVGAAsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbVGAAsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:48:13 -0400
Received: from web52607.mail.yahoo.com ([206.190.39.145]:61316 "HELO
	web52607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263179AbVGAAsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:48:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ALp+enBWG2kqg75f4SLnGidL8ZaGw4urZGEC5e+fSz0MeapTFvUlUz2Cpd1pAWdKcvJ/Lz2yArffH9Vi7mOKPoia9reohc9pqz5A1nUPTyTA7l1azDKJzWYaBc1iHB20tltARRN6staJRhlhxCbYzpV+WHdNVZEcTsfOgsuJBJY=  ;
Message-ID: <20050701004801.50905.qmail@web52607.mail.yahoo.com>
Date: Fri, 1 Jul 2005 10:48:00 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [PROBLEM] kernel BUG at include/linux/blkdev.h:601
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050630153717.GB2243@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jens Axboe <axboe@suse.de> wrote:
> On Thu, Jun 30 2005, Srihari Vijayaraghavan wrote:
> > --- Srihari Vijayaraghavan
> > <sriharivijayaraghavan@yahoo.com.au> wrote:
> [...] 
> > 2.6.13-rc1 (plus Hugh's get_request patch) doesn't
> > suffer from this problem, unlike 2.6.12 and
> 2.6.12-git
> > releases.
> 
> That's a little strange, as there should be no
> changes in this area so
> far. Are you 100% sure?

Absolutely. 2.6.12 and 2.6.12-git9 crash within
minutes/seconds; OTOH, 2.6.13-rc1 (plus Hugh's patch)
survives this torture test for hours (despite
generating 30+ MB of kernel/IDE error messages :). No
OOPS, no BUGs, no panics, just truck load of error
messages.

I haven't tested whether earlier releases of 2.6
suffer from this (such as 2.6.10, 2.6.11 ..) or other
hardware combinations exhibit the same problem etc.
Tell me, if you want me to.

Thanks
Hari



	

	
		
____________________________________________________ 
Do you Yahoo!? 
Try Yahoo! Photomail Beta: Send up to 300 photos in one email! 
http://au.photomail.mail.yahoo.com
