Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWHOLS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWHOLS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWHOLS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:18:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:52684 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030246AbWHOLS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:18:56 -0400
Date: Tue, 15 Aug 2006 13:18:47 +0200
From: Andi Kleen <ak@muc.de>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <patches@x86-64.org>
Subject: Re: [patches] Re: backtracer stuck in apic_timer_interrupt
Message-Id: <20060815131847.e7db9468.ak@muc.de>
In-Reply-To: <44E1C3C2.76E4.0078.0@novell.com>
References: <200608040920.42076.ak@suse.de>
	<44E1C3C2.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also making the call_trace command line option now conditional upon
> CONFIG_STACK_UNWIND (as it's meaningless otherwise).

Thanks added (even though it was some effort because the patch was
word wrapped and that code had changed in my tree) 

-Andi
