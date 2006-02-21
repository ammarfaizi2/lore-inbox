Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWBUVpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWBUVpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWBUVpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:45:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932134AbWBUVpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:45:09 -0500
Date: Tue, 21 Feb 2006 13:43:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1 console (radeonfb) not resumed after s2ram
Message-Id: <20060221134323.6a5e5a95.akpm@osdl.org>
In-Reply-To: <20060221190031.GA3531@inferi.kami.home>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<20060221190031.GA3531@inferi.kami.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <malattia@linux.it> wrote:
>
> On Mon, Feb 20, 2006 at 04:26:15AM -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> 
> After suspend the system is fully working except it doesn't resume the
> console (I'm using radeonfb). If suspending from X the thing comes back,
> X working ok, but switching to vt1 I see the console completely garbled.
> Reverting radeonfb-resume-support-for-samsung-p35-laptops.patch (_wild_
> guess) does not help.
> Any good candidate?
> 

Did you apply the patches in the hot-fixes directory? 
revert-reset-pci-device-state-to-unknown-after-disabled.patch might help.

