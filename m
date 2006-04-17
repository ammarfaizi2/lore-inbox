Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWDQOcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWDQOcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWDQOcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:32:22 -0400
Received: from dvhart.com ([64.146.134.43]:17103 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751022AbWDQOcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:32:22 -0400
Message-ID: <4443A6D9.6040706@mbligh.org>
Date: Mon, 17 Apr 2006 07:31:53 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
In-Reply-To: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert M. Stockmann wrote:
> Hi,
> 
> I noticed that the latest editions of RedHat EL 4.3 and direct
> descendants today need a program called irqbalance to activate
> true SMP IRQ load balancing for your machine's hardware.
> 
> If one boots a SMP kernel (2.4.xx or 2.6.xx) kernel on a machine
> which either has 2 or more physical CPU's (also dual-core CPU's) 
> , and one does not start up the irqbalance util from the
> kernel-utils package ( see e.g. 

There is an in-kernel IRQ balancer. Redhat just choose to turn it
off, and do it in userspace instead. You can re-enable it if you
compile your own kernel.

M.
