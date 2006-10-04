Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030644AbWJDIB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030644AbWJDIB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030646AbWJDIB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:01:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030644AbWJDIB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:01:58 -0400
Date: Wed, 4 Oct 2006 01:01:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-Id: <20061004010137.f0cc9531.akpm@osdl.org>
In-Reply-To: <20061004074142.GA29332@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	<20061002210053.16e5d23c.akpm@osdl.org>
	<20061003084729.GA24961@elte.hu>
	<20061003103503.GA6350@elte.hu>
	<20061003203620.d85df9c6.akpm@osdl.org>
	<20061004064620.GA22364@elte.hu>
	<20061004003228.98ec3b39.akpm@osdl.org>
	<20061004074142.GA29332@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 09:41:42 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Yet initscripts take a long time (especially applying the ipfilter 
> > firewall rues for some reason), and `startx' takes a long time, etc.  
> > This kernel takes 112 seconds to boot to a login prompt - other 
> > kernels take 56 seconds (interesting ratio..)
> 
> you are still using the non-hres config, correct? (so this is still 
> collateral damage on vanilla kernel functionality)
> 

yup.
