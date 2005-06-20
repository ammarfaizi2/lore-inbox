Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVFTL6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFTL6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVFTL6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:58:18 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:12720 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261214AbVFTL4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:56:24 -0400
Date: Mon, 20 Jun 2005 05:58:51 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel()
 calls
In-Reply-To: <20050619201439.GA1302@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0506200557520.12042@montezuma.fsmlabs.com>
References: <20050618002021.GA2892@us.ibm.com>
 <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
 <20050619201439.GA1302@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, 19 Jun 2005, Paul E. McKenney wrote:

> I did update Documentation/RCU/* to change the uses of synchronize_kernel(),
> but was relying on the documentation-extraction stuff to build the API
> documentation.  So I have the following header comments in mainline:
> 
> Hmmm...  Looks like some repair is needed in the synchronize_sched()
> header comment -- and I vaguely remember someone pointing this out. :-/
> See patch below for a fix.
> 
> Glancing through the Documentation/RCU/* stuff again, it could definitely
> use some help.  Would it help if I added an example use of
> synchronize_sched() that interacted with NMIs?

Thanks that looks like it covers it.

	Zwane

