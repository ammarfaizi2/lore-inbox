Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263533AbVBEJ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbVBEJ3m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbVBEJ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:29:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:32744 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266118AbVBEJYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:24:39 -0500
Subject: Re: question on symbol exports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <4203D793.1040604@nortel.com>
References: <41FECA18.50609@nortelnetworks.com>
	 <1107243398.4208.47.camel@laptopd505.fenrus.org>
	 <41FFA21C.8060203@nortelnetworks.com>
	 <1107273017.4208.132.camel@laptopd505.fenrus.org>
	 <20050204203050.GA5889@dmt.cnet>  <4203D793.1040604@nortel.com>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 20:19:08 +1100
Message-Id: <1107595148.30302.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It turns out that to call ptep_clear_flush_dirty() on ppc64 from a 
> module I needed to export the following symbols:
> 
> __flush_tlb_pending
> ppc64_tlb_batch
> hpte_update

Any reason why you need to call that from a module ? Is the module
GPL'd ?

Ben.


