Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUDHRXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUDHRXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:23:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:21944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262071AbUDHRXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:23:03 -0400
Date: Thu, 8 Apr 2004 10:12:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Neil Schemenauer <nas@arctrix.com>, linux-kernel@vger.kernel.org
Subject: Re: capwrap: granting capabilities without fs support
Message-ID: <20040408101236.F22989@build.pdx.osdl.net>
References: <fa.g8lp2iv.1vlsqhp@ifi.uio.no> <40755CAC.60502@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40755CAC.60502@myrealbox.com>; from luto@myrealbox.com on Thu, Apr 08, 2004 at 07:07:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> When I have time (hopefully real soon now), I'll post a patch to actually fix 
> capabilities.  With that patch, this can be a trivial wrapper script instead of 
> a kernel module.  Note that this could be _very_ dangerous if glibc does the 
> wrong thing (I don't know whether it does, though).

I agree, between my patch or Andy's patch, it makes more sense to fix
capabilities to be more useable, rather than add this new module.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
