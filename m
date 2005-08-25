Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVHYA6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVHYA6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVHYA6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:58:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37095 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932456AbVHYA6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:58:02 -0400
Date: Wed, 24 Aug 2005 17:57:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, paulus@samba.org, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
Message-Id: <20050824175751.3a45d031.pj@sgi.com>
In-Reply-To: <430D0A95.30208@yahoo.com.au>
References: <20050824111510.11478.49764.sendpatchset@jackhammer.engr.sgi.com>
	<20050824112640.GB5197@in.ibm.com>
	<20050824044648.66f7e25a.pj@sgi.com>
	<430C617E.8080002@yahoo.com.au>
	<20050824133107.2ca733c3.pj@sgi.com>
	<430D0A95.30208@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> and that it looks like what I was thinking about.

Ok - I almost have my crosstool installation healthy again.
I will actually see to it that my patch builds this time for
whatever arch's I can test on, and send this simple disabling
of sched domain mangling from cpuset-land as a real patch.

I have a couple other commitments - it will be 6 to 12 hours
before I send it in, unless someone asks for a half-baked
version sooner.

> We need to revert to a stable behaviour, however we can't risk
> major surgery to get there.

Yup.  Agreed.

Thanks for looking into this, Nick.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
