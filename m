Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbUANAca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUANAc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:32:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:64438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266283AbUANAcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:32:22 -0500
Date: Tue, 13 Jan 2004 16:32:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initializing a task
Message-ID: <20040113163205.B30560@osdlab.pdx.osdl.net>
References: <20040113152026.34ADA3966@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040113152026.34ADA3966@sitemail.everyone.net>; from bluefoxicy@linux.net on Tue, Jan 13, 2004 at 07:20:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* john moser (bluefoxicy@linux.net) wrote:
> I'm having severe severe issues with my jail.  Inside do_fork() I have
> code for

Did you look at the INIT_TASK() macro for initialization.  Also, you may
take a look at another jail implementation (done to emulate BSD jails)
done as a security module.
										http://mail.immunix.com/pipermail/linux-security-module/2003-December/4990.html

thanks
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
