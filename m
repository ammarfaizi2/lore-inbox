Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUDEVNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUDEVKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:10:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:27333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263202AbUDEVIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:08:12 -0400
Date: Mon, 5 Apr 2004 14:08:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: John Stoffel <stoffel@lucent.com>, Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
Message-ID: <20040405140810.C22989@build.pdx.osdl.net>
References: <16497.48378.82191.330004@gargle.gargle.HOWL> <20040405205412.60071.qmail@web40504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040405205412.60071.qmail@web40504.mail.yahoo.com>; from serge_lozovsky@yahoo.com on Mon, Apr 05, 2004 at 01:54:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergiy Lozovsky (serge_lozovsky@yahoo.com) wrote:
> No :-) What you suggest is kernel should receive
> system call from user space. Instead of handling it -
> kernel should forward it back to userspace, than it
> should be forwarded back to the kernel. Looks not very
> nice to me. Why not to handle security policy inside
> the kernel as it is done for the file permissions and
> root priveleges?

All this can be done w/out having a LISP interpretter coming along for the
ride, that's the point of the other posters.  With LSM you have a
framework for implementing your own security model and enforcing your own
policies.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
