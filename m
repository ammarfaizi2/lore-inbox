Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUB2Xlo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbUB2Xlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:41:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:3715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262178AbUB2Xlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:41:42 -0500
Date: Sun, 29 Feb 2004 15:42:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1 and aic7xxx
Message-Id: <20040229154243.64d55be9.akpm@osdl.org>
In-Reply-To: <200403010030.27481.cova@ferrara.linux.it>
References: <A6974D8E5F98D511BB910002A50A6647615F2BAD@hdsmsx402.hd.intel.com>
	<1077521296.12675.81.camel@dhcppc4>
	<200403010030.27481.cova@ferrara.linux.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Coatti <cova@ferrara.linux.it> wrote:
>
> 
>  >
>  > Fabio,
>  > Any chance you can isolate further where this broke by finding the
>  > latest release where it worked properly?
>  >
>  > ie. does vanilla 2.6.3 work if you back out the mm patch?
> 
>  I don't know if this come late (I've been quite busy) anyway I've found that 
>  vanilla 2.6.3 and 2.6.2 works just fine; mmX versions hangs (mm1, mm2, etc..)
>  The latest working mm version is 2.6.3-rc3-mm1
>  I've also tried 2.6.4-rc1 and 2.6.4-rc1-mm1: 2.6.4-rc1 boots and works, -mm1 
>  hang at the very same point.
> 
>  > If 2.6.3 works, then I'd be interested if the following 2.6.3 patch
>  > breaks it:
>  >http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.3/acpi-20040116-2.6.3.diff.gz
> 
>  Sorry, but I can't find this patch, maybe it's outdated; if you can give me a 
>  new link, I'll try asap.

If you have the time, please test 2.6.4-rc1 and then test 2.6.4-rc1
plus

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm1/broken-out/bk-acpi.patch

thanks.
