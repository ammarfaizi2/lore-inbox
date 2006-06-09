Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWFIWkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWFIWkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWFIWkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:40:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2692 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751422AbWFIWkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:40:11 -0400
Date: Fri, 9 Jun 2006 18:40:07 -0400
From: Dave Jones <davej@redhat.com>
To: Zbigniew Luszpinski <zbiggy@o2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD updated in May powernow driver for Linux kernels
Message-ID: <20060609224007.GO7420@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Zbigniew Luszpinski <zbiggy@o2.pl>, linux-kernel@vger.kernel.org
References: <200606100031.41233.zbiggy@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606100031.41233.zbiggy@o2.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 12:31:41AM +0200, Zbigniew Luszpinski wrote:
 > In May 2006 AMD updated their powernow/cool'n'quiet driver for Athlons 64 to 
 > 1.60.1 version. In kernel 2.6.16.20 there is still 1.60.0. I thought you 
 > would like to know about it and update powernow files in kernel sources. I 
 > use 1.60.1 now with kernel 2.6.16.20 on Athlon64 3000+ Venice and seems to be 
 > working well.
 > 
 > More info here:
 > http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_871_9706,00.html
 > (look at second description)
 > 
 > Direct download:
 > http://www.amd.com/us-en/assets/content_type/utilities/linux_frequency_driver-1.60.01.tar.bz2

2.00.00 is queued for 2.6.18 once it opens up.

Are you seeing some specific problem with the driver in 2.6.16 that makes
this an essential upgrade for you ? If so, I'll investigate and get
the relevent fix into 2.6.16.21

Theres one oops fix which should go in, but other than that,
it's mostly been cleanups and support for next generation hardware
which isn't even shipping yet.

		Dave

-- 
http://www.codemonkey.org.uk
