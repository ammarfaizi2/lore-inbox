Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbTLKKS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTLKKS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:18:26 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:8073 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S264874AbTLKKSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:18:21 -0500
Date: Thu, 11 Dec 2003 11:16:55 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031211101655.GB5192@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
References: <20031210231729.GC28912@k3.hellgate.ch> <Pine.LNX.4.44.0312102027001.25222-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312102027001.25222-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 20:31:40 -0500, Rik van Riel wrote:
> Hmmm, those definitions have changed a little from the
> OS books I read ;))
> 
> > - It is light thrashing when load control has no advantage.
> 
> This used to be called "no thrashing" ;)

Fair enough, but that was before Linux 2.6 <g>.

kbuild benchmark, execution time in seconds (median over ten runs):
 74	2.6.0-test11, 256 MB RAM
115	2.4.21, 64 MB RAM
539	2.6.0-test11, 64 MB RAM

We can call it lousy paging, that'll be fine with me.

> Also, it would make the job of a load control mechanism
> really easy to define:
> 
> 	"Prevent the system from thrashing"

"... once all other means are exhausted". Then I'll buy it.

Roger
