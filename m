Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVIQAQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVIQAQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVIQAQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:16:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750778AbVIQAQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:16:40 -0400
Date: Fri, 16 Sep 2005 17:15:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: greg@kroah.com, kay.sievers@vrfy.org, jirislaby@gmail.com,
       dominik.karall@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-Id: <20050916171553.35b30af2.akpm@osdl.org>
In-Reply-To: <200509162353.j8GNrX2B007036@turing-police.cc.vt.edu>
References: <20050916022319.12bf53f3.akpm@osdl.org>
	<200509162042.07376.dominik.karall@gmx.net>
	<432B2101.9080806@gmail.com>
	<20050916195903.GE22221@vrfy.org>
	<20050916213003.GB13604@kroah.com>
	<200509162353.j8GNrX2B007036@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
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
> be needed? Or just the 'input-prepare-to-sysfs-integration.patch' and following?
> 

These need to go, I believe:

input-core-implement-class-hierachy.patch
input-core-implement-class-hierachy-hdaps-fixes.patch
input-core-remove-custom-made-hotplug-handler.patch
input-convert-input-handlers-to-class-interfaces.patch
input-convert-to-seq_file.patch

Or you can take your chances with
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.5.gz which
is kinda rc1-mm1 without those 28 patches.

