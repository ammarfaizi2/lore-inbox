Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754801AbWKIJVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbWKIJVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbWKIJVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:21:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:35734 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754798AbWKIJVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:21:41 -0500
Date: Thu, 9 Nov 2006 10:21:31 +0100
From: Olaf Kirch <okir@suse.de>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       davem@sunset.davemloft.net, kuznet@ms2.inr.ac.ru,
       netdev@vger.kernel.org
Subject: Re: 2.6.19-rc1: Volanomark slowdown
Message-ID: <20061109092131.GA19715@suse.de>
References: <1162924354.10806.172.camel@localhost.localdomain> <1163001318.3138.346.camel@laptopd505.fenrus.org> <20061108162955.GA4364@suse.de> <1163011132.10806.189.camel@localhost.localdomain> <20061108221028.GA16889@suse.de> <1163023652.10806.203.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163023652.10806.203.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 02:07:32PM -0800, Tim Chen wrote:
> In my testing, the CPU utilization is at 100%.  So
> increase in ACKs will cost CPU to devote more
> time to process those ACKs and reduce throughput.

Oh, I see. I would test on a real network with real clients. I doubt
you would observe a noticeable effect there.

Olaf
-- 
Walks like a duck. Quacks like a duck. Must be a chicken.
