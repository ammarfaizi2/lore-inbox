Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUI3IQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUI3IQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbUI3IQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:16:18 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:51391 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268892AbUI3IQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:16:05 -0400
Message-ID: <415BC0BC.6040902@yahoo.com.au>
Date: Thu, 30 Sep 2004 18:15:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
References: <1096420339.15060.139.camel@arrakis>
In-Reply-To: <1096420339.15060.139.camel@arrakis>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> IA64 already has their own version of SD_NODE_INIT, tuned for their
> extremely large machines.  I think that all arches would benefit from
> having their own, arch-specific SD_NODE_INIT initializer, rather than
> the one-size-fits-all variant we've got now.
> 

I suppose the patch is pretty good (IIRC Martin liked the idea).
I guess it will at least increase the incidence of copy+paste,
if not getting people to think harder ;)

Can I be lame and ask that you keep this around until closer
to 2.6.10? I have a few possible scheduler performance
improvments that I'd like to get tested in -mm after 2.6.9
and this would make things a bit harder :P

I don't think anyone is looking at getting any tweaks in before
then...
