Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265302AbUFXTWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbUFXTWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUFXTWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:22:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:18147 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264826AbUFXTP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:15:57 -0400
Date: Thu, 24 Jun 2004 12:15:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, limin@engr.sgi.com,
       pwil3058@bigpond.net.au
Subject: Re: [PATCH] Process Aggregates (PAGG) for 2.6.7
Message-ID: <20040624121552.Q21045@build.pdx.osdl.net>
References: <20040624115704.O22989@build.pdx.osdl.net> <200406241912.i5OJC1X03468@dbear.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200406241912.i5OJC1X03468@dbear.engr.sgi.com>; from limin@dbear.engr.sgi.com on Thu, Jun 24, 2004 at 12:12:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Limin Gu (limin@dbear.engr.sgi.com) wrote:
> > So, this is really ioctl.  This should be exposed in fs interface, or
> > the primitives should be promoted to first class syscalls if others can
> > use this.
> 
> Yes, that would be better. 
> 
> But right now, we only have CSA ( Comprehensive System Accounting) use 
> job, :)

Sure, even as it stands it should probably move to an fs interface, and
what about reuse/consolidation with CKRM needs?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
