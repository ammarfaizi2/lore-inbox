Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUHCVsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUHCVsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUHCVsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:48:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:14471 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266887AbUHCVp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:45:29 -0400
Date: Tue, 3 Aug 2004 14:45:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, andrea@suse.de
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803144518.P1924@build.pdx.osdl.net>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031653350.5948-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0408031653350.5948-100000@dhcp83-102.boston.redhat.com>; from riel@redhat.com on Tue, Aug 03, 2004 at 04:54:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> On Thu, 29 Jul 2004, Chris Wright wrote:
> 
> > 2) mlock_user isn't ever set, so SHM_LOCK accounting looks broken
> > (trivial to fix).
> 
> Should be fixed by the patch below.  Does this look
> acceptable ?

Yeah, sure does.  Could also pass the cached user struct instead of
current->user to shmem_lock, might fit in 80 cols. ;-)

thanks,
-chris
--
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
