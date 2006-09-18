Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWIRTRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWIRTRr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWIRTRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:17:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54490 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751772AbWIRTRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:17:46 -0400
Subject: Re: MARKER mechanism, try 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Ingo Molnar <mingo@elte.hu>, "Frank Ch. Eigler" <fche@redhat.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <20060918174742.GA27398@Krystal>
References: <20060917112128.GA3170@localhost.usen.ad.jp>
	 <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal>
	 <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com>
	 <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com>
	 <20060918150231.GA8197@elte.hu> <20060918163042.GA15192@Krystal>
	 <20060918162828.GA22910@elte.hu>  <20060918174742.GA27398@Krystal>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 20:39:44 +0100
Message-Id: <1158608386.6069.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 13:47 -0400, ysgrifennodd Mathieu Desnoyers:
> "cannot use printk" (used in scheduler, NMIs, wakeup, printk itself)
>                     (nothing, kprobe, jumpprobe or tracer)

Also sometimes in character drivers - if it's the console device and you
printk in the driver code you go boom.

