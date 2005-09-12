Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVIMBu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVIMBu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 21:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVIMBu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 21:50:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932298AbVIMBu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 21:50:26 -0400
Subject: Re: [Aurora-sparc-devel] [2.6.13-rc6-git13/sparc64]: Slab
	corruption (possible stack or buffer-cache corruption)
From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: aurora-sparc-devel@lists.auroralinux.org, linux-kernel@vger.kernel.org,
       davem@redhat.com, sparclinux@vger.kernel.org
In-Reply-To: <20050912.134122.54246336.davem@davemloft.net>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
	 <1126536316.25031.66.camel@localhost.localdomain>
	 <20050912.134122.54246336.davem@davemloft.net>
Content-Type: text/plain
Organization: Red Hat
Date: Mon, 12 Sep 2005 15:45:05 -0500
Message-Id: <1126557905.3375.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 (2.4.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 13:41 -0700, David S. Miller wrote:
> From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
> Date: Mon, 12 Sep 2005 09:45:16 -0500
> 
> > We've been seeing this intermittently on arthur since Aurora 1.0 (2.4).
> 
> That's amazing given that half of those SLAB functions in
> the backtrace simply do not exist in 2.4.x :-)  Can you quote
> a 2.4.x version of such a backtrace?  Thanks a lot.

You're right. I first saw this on 2.6.4:

http://marc.theaimsgroup.com/?l=linux-sparc&m=107823740703651&w=2

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

