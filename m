Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTIIVGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTIIVGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:06:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:28099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264499AbTIIVGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:06:52 -0400
Date: Tue, 9 Sep 2003 14:06:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] (improved) LSM root_plug fixup
Message-ID: <20030909140644.F7617@osdlab.pdx.osdl.net>
References: <20030804200130.GA8719@outpost.ds9a.nl> <20030805095840.GA29628@outpost.ds9a.nl> <20030904234738.GA12556@kroah.com> <20030909083752.GB12415@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030909083752.GB12415@outpost.ds9a.nl>; from ahu@ds9a.nl on Tue, Sep 09, 2003 at 10:37:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* bert hubert (ahu@ds9a.nl) wrote:
> Please find new patch attached, rediffed against test5. The directory in the
> patch says 2.6.0-test2, but it is against test5. Compiles & works for me.

It's working for me.  I put it in the LSM tree with one minor typo fixed:

> +++ linux-2.6.0-test2-bk-ahu/security/commoncap.c	2003-09-09 09:56:53.000000000 +0200
> @@ -0,0 +1,353 @@
> +/* Common capabilities, needed by capability.o and root_cap.o 

s/root_cap/root_plug/

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
