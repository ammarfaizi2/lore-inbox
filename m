Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbULZQ14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbULZQ14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbULZQ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:27:56 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:59103 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261696AbULZQ1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:27:55 -0500
Date: Sun, 26 Dec 2004 08:27:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Larry McVoy <lm@bitmover.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lease.openlogging.org is unreachable
Message-ID: <20041226162727.GA27116@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1104077531.5268.32.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104077531.5268.32.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 10:12:10AM -0600, James Bottomley wrote:
> > The interesting thing is that the code already has a backup in it and I just
> > checked that code path and it works.
> > 
> > Has anyone else been shut down because of lease.openlogging.org being down
> > and if so what version of BK were you running please?
> 
> I believe I've reported this problem to you and support@bitmover.com
> several times.
> 
> There's something in BK that refuses to work when it can't contact
> lease.openlogging.org, regardless of whether you just renewed the lease
> or not.  This keeps biting me when I try to use BK disconnected from the
> internet (usually while travelling).

I suspect that your hostname changes when you disconnect.  Leases are 
issued on a per host basis.  If you make your hostname constant when
you unplug it should work.  If it doesn't, let us know.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
