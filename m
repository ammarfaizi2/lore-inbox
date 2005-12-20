Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVLTQyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVLTQyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVLTQys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:54:48 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:47240 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751114AbVLTQyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:54:47 -0500
Date: Tue, 20 Dec 2005 09:54:46 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: William Cohen <wcohen@nc.rr.com>
Cc: eranian@hpl.hp.com, William Cohen <wcohen@redhat.com>,
       perfctr-devel@lists.sourceforge.net, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.15-rc5-git3 perfmon2 new code base + libpfm available
Message-ID: <20051220165446.GY2361@parisc-linux.org>
References: <20051215104604.GA16937@frankl.hpl.hp.com> <43A1DE94.8050105@redhat.com> <20051215215921.GJ18331@frankl.hpl.hp.com> <43A1ECDF.9040200@nc.rr.com> <20051215231510.GC18796@frankl.hpl.hp.com> <43A82BAE.1010008@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A82BAE.1010008@nc.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 11:05:02AM -0500, William Cohen wrote:
> Dec 20 10:29:47 trek kernel: Unable to handle kernel paging request at 
> virtual address 6b6b6ba7

mm/slab.c:#define POISON_FREE   0x6b    /* for use-after-free poisoning */

