Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVHWNHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVHWNHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVHWNHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:07:52 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:20244 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1750766AbVHWNHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:07:51 -0400
Date: Tue, 23 Aug 2005 14:07:26 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-rc6-mm2 (hangs on non-SMP x86-64 and oopses)
Message-ID: <20050823130726.GC3156@linux-mips.org>
References: <20050822213021.1beda4d5.akpm@osdl.org> <200508231451.52521.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508231451.52521.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Tue, Aug 23, 2005 at 02:51:51PM +0200, Rafael J. Wysocki wrote:

> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/
> > 
> > - Various updates.  Nothing terribly noteworthy.
> 
> It hangs solig during boot (after starting kjournald) on Asus L5D (non-SMP x86-64),
> which is caused by this patch:
> 
> 8250-serial-console-locking-bug-spelling-fix.patch
> 
> (from binary search).
> 
> If this patch is reverted, it oopses like in the following trace.

I thought this one was already pulled?

  Ralf
