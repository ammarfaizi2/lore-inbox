Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVIZLSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVIZLSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 07:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVIZLSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 07:18:24 -0400
Received: from mx01.cybersurf.com ([209.197.145.104]:59859 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S1751200AbVIZLSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 07:18:23 -0400
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Michael Bellion <mbellion@hipac.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <200509260445.46740.mbellion@hipac.org>
References: <200509260445.46740.mbellion@hipac.org>
Content-Type: text/plain
Organization: unknown
Date: Mon, 26 Sep 2005 07:18:12 -0400
Message-Id: <1127733492.6215.274.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-26-09 at 04:45 +0200, Michael Bellion wrote:
> Hi
> 
> I am happy to announce the release of nf-HiPAC version 0.9.0
> 
> During the development of version 0.9.0 everything was ported to Linux kernel 
> 2.6 and large parts of the kernel code have been rewritten.
> The kernel patch is now fairly non-intrusive: it only adds one simple function 
> to ip_tables.c. The rest of the patch introduces new files to the kernel. 
> The new release fixes all known bugs and also introduces some new features.
> 
> Since the last release I have become part of MARA Systems AB 
> ( http://www.marasystems.com ). MARA Systems AB is now the commercial backer 
> of the HiPAC Project and finances it completely. Together MARA Systems and I 
> will make sure that HiPAC is actively maintained and further developed under 
> the GNU GPL.
> 
> 

Congratulations to yourself as well as your sponsor. I think this is
useful. 

The iptables wrapper is certainly valuable. 

Can you post some numbers relative to iptables? 
Some tests with the following parameters would be helpful:
- Variable incoming packet rate (in packets per second)
- Variable packet sizes
- Variable number of users/filters
- Effect of adding/removing/modifying policies while under different
incoming traffic rates.

Just even simple non-stateful comparisons like i did with tc over here:

http://www.suug.ch/sucon/04/slides/pkt_cls.pdf

Or even better when you do these tests also try out with tc filter.

cheers,
jamal

