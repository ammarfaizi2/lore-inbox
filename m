Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUGHXYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUGHXYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 19:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUGHXYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 19:24:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:56988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261426AbUGHXYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 19:24:16 -0400
Date: Thu, 8 Jul 2004 16:24:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris White <webmaster@securesystem.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel fchown() exploit status?
Message-ID: <20040708162414.I1973@build.pdx.osdl.net>
References: <40EDB764.6060107@securesystem.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40EDB764.6060107@securesystem.info>; from webmaster@securesystem.info on Fri, Jul 09, 2004 at 06:06:44AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris White (webmaster@securesystem.info) wrote:
> There was a recent security announcment regarding a vulnerability with 
> the fchown function.
> 
> Only a few distrobutions (red hat/suse) have fixed the issue, but I've 
> yet to see a general patch for it.

Patches are in both 2.4 and 2.6 bk trees.  2.4.27-rc3 has this fixed.
There hasn't been a 2.6.8-rc release since the patches went in to 2.6

For 2.4 see these patches:
http://linux.bkbits.net:8080/linux-2.4/cset@40e725f8sMbNK6BEQmRi5fWfux8l8A
http://linux.bkbits.net:8080/linux-2.4/cset@40e733598ODR85iS5HRft0zJTnDCHA

For 2.6 see these patches:
http://linux.bkbits.net:8080/linux-2.6/cset@40e62e18vom8K1fHgbJfe1oQ6mdkkQ
http://linux.bkbits.net:8080/linux-2.6/cset@40e6158bme9avS6IqahBN0wa9zx7LQ

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
