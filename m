Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUKMWT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUKMWT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUKMWT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:19:28 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:19210 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261186AbUKMWT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:19:26 -0500
Date: Sat, 13 Nov 2004 23:19:03 +0100
From: Jedi/Sector One <lkml@pureftpd.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5 [u]
Message-ID: <20041113221925.GA2196@c9x.org>
References: <20041111012333.1b529478.akpm@osdl.org> <1100368553.12239.3.camel@nosferatu.lan> <1100380593.12663.1.camel@nosferatu.lan> <20041113132232.5c201000.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113132232.5c201000.akpm@osdl.org>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 01:22:32PM -0800, Andrew Morton wrote:
> Could you please try:
> 
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch
> patch -R -p1 < futex_wait-fix.patch

  It seems that reverting this patch indeed fixes the Apache + NPTL issue.

