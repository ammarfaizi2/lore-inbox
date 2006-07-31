Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWGaXrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWGaXrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWGaXrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:47:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:49843 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750907AbWGaXrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:47:05 -0400
From: Andi Kleen <ak@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] io_apic fix spinlock in resume [Was: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]]
Date: Tue, 1 Aug 2006 01:46:44 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       mingo@redhat.com
References: <io_apic_has_to_be_repaired@huhuhu_blaah>
In-Reply-To: <io_apic_has_to_be_repaired@huhuhu_blaah>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010146.44818.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> io_apic fix spinlock in resume
> 
> In io_apic class resume after Andi's cleanup was wiped out one unlock of
> spinlock. Get him back to allow suspending (and resuming) of machine.

Oops. I fixed the original patch. Thanks.

-Andi
