Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUDNUQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUDNUQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:16:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:17077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261597AbUDNUQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:16:00 -0400
Date: Wed, 14 Apr 2004 13:15:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.5-mm4] vfs_readdir optimizations
Message-ID: <20040414131559.R22989@build.pdx.osdl.net>
References: <1081972032.5445.30.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1081972032.5445.30.camel@bluerhyme.real3>; from Fabian.Frederick@skynet.be on Wed, Apr 14, 2004 at 09:47:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabian Frederick (Fabian.Frederick@skynet.be) wrote:
> -Remove unuseful gotos
> -ENOENT case on DEADDIR

Couple things.  It's useful to generate some numbers to show an
optimization is worthwhile.  And code readability/maintainability is
important to maintain correctness.  You may look at the assembly and
find that there is no real optimization with the changes you've proposed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
