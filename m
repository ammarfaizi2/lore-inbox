Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVEWMlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVEWMlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 08:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVEWMlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 08:41:07 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:39881 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261378AbVEWMlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 08:41:03 -0400
Subject: Re: PROBLEM: computer freezes / harddisk led stays on after S3
	resume
From: Erik Slagter <erik@slagter.name>
To: Stefan Seyfried <seife@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <428E0202.8090709@suse.de>
References: <1116408408.3505.26.camel@localhost.localdomain>
	 <428E0202.8090709@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 May 2005 14:40:08 +0200
Message-Id: <1116852008.8257.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 17:28 +0200, Stefan Seyfried wrote:
> Erik Slagter wrote:
> > 1. computer freezes / harddisk led stays on after S3 resume
> 
> > 7.7. Dell Inspiron 9300, Pentium M, ICH6(M), Fujitsu SATA harddisk, SONY
> > ATAPI DVD+R/W. libata is running using piix according to dmesg, ahci
> > doesn't work (see other problem report).
> 
> SATA had no suspend support until a few weeks ago, when Jens Axboe
> started fixing it. I have no idea in which kernel version his patches
> will appear, but they were on the list some days ago.

I finally found the patches and applied them (manually, patch complete
barfed ;-)). And now it miraculously works. As far as I'm concerned,
these patches are ready for inclusion ;-)
