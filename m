Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUIIQTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUIIQTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUIIQTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:19:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:62422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266188AbUIIQTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:19:32 -0400
Date: Thu, 9 Sep 2004 09:19:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909091931.K1973@build.pdx.osdl.net>
References: <20040909162200.GB9456@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909162200.GB9456@lkcl.net>; from lkcl@lkcl.net on Thu, Sep 09, 2004 at 05:22:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> wow, gosh, it works.
> 
> okay, this is a patch to add support in iptables for per-program
> firewall filtering.
> 
> also included is the patches to iptables-1.2.11.
> 
> i have confidence that this patch will provide support for
> BOTH incoming AND outgoing per-program packet filtering.

Programs can share a socket.  Incoming is in interrupt context.  You
have no idea who will be woken up.  How do you handle this?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
