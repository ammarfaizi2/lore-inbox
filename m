Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263672AbUJ2X6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbUJ2X6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUJ2XpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:45:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:6856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263690AbUJ2Xjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:39:46 -0400
Date: Fri, 29 Oct 2004 16:39:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steven Dake <sdake@mvista.com>
Cc: Mark Haverkamp <markh@osdl.org>, Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 kernel oops with openais
Message-ID: <20041029163944.H14339@build.pdx.osdl.net>
References: <1099090282.14581.19.camel@persist.az.mvista.com> <1099091302.13961.42.camel@markh1.pdx.osdl.net> <1099091816.14581.22.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099091816.14581.22.camel@persist.az.mvista.com>; from sdake@mvista.com on Fri, Oct 29, 2004 at 04:16:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Dake (sdake@mvista.com) wrote:
> well probably all related..  The best way around the memset problem is
> to comment out the code that does the mlockall (the function is
> aisexec_mlockall().  This then allows all memory allocations to
> succeed.  I think there must be some new limit with mlockall in the
> 2.6.9 kernel series or later.

What's the mlock issue?  I changed that code about 2.6.9-rc4.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
