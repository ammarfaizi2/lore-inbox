Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUJ3ABr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUJ3ABr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbUJ2X7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:59:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:48591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263713AbUJ2Xpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:45:52 -0400
Date: Fri, 29 Oct 2004 16:45:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steven Dake <sdake@mvista.com>
Cc: Chris Wright <chrisw@osdl.org>, Mark Haverkamp <markh@osdl.org>,
       Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 kernel oops with openais
Message-ID: <20041029164551.U2357@build.pdx.osdl.net>
References: <1099090282.14581.19.camel@persist.az.mvista.com> <1099091302.13961.42.camel@markh1.pdx.osdl.net> <1099091816.14581.22.camel@persist.az.mvista.com> <20041029163944.H14339@build.pdx.osdl.net> <1099093468.1207.8.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099093468.1207.8.camel@persist.az.mvista.com>; from sdake@mvista.com on Fri, Oct 29, 2004 at 04:44:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Dake (sdake@mvista.com) wrote:
> The use case is this (on 2.6.9):
> 
> task starts as uid 0
> task calls mlockall
> task allocates several mb of ram
> task drops root privs to non prived uid
> further memory allocations fail

What's the RLIMIT_MEMLOCK?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
