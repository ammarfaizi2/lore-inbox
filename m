Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVIQAoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVIQAoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVIQAoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:44:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:14544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750790AbVIQAoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:44:12 -0400
Date: Fri, 16 Sep 2005 17:10:22 -0700
From: Greg KH <greg@kroah.com>
To: Valdis.Kletnieks@vt.edu
Cc: Kay Sievers <kay.sievers@vrfy.org>, Jiri Slaby <jirislaby@gmail.com>,
       Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-ID: <20050917001021.GA16041@kroah.com>
References: <20050916022319.12bf53f3.akpm@osdl.org> <200509162042.07376.dominik.karall@gmx.net> <432B2101.9080806@gmail.com> <20050916195903.GE22221@vrfy.org> <20050916213003.GB13604@kroah.com> <200509162353.j8GNrX2B007036@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509162353.j8GNrX2B007036@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 07:53:32PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 16 Sep 2005 14:30:04 PDT, Greg KH said:
> > > > >On Friday 16 September 2005 11:23, Andrew Morton wrote:
> > > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
> 
> > Yes, Andrew, can you please drop these patches, they will cause lots of
> > problems with users due to the above mentioned issues.
> 
> For those of us playing along at home -
> 
> Would doing a 'patch -R' of all 30 patches listed in "Big input/sysfs changes"
> be needed?

That's probably the safest.

>  Or just the 'input-prepare-to-sysfs-integration.patch' and following?

Don't really know if stuff would still build if you only reverted that
one.

thanks,

greg k-h
