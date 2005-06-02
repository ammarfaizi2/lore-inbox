Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFBR0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFBR0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 13:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFBR0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 13:26:40 -0400
Received: from mail.suse.de ([195.135.220.2]:63622 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261194AbVFBR0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 13:26:39 -0400
Date: Thu, 2 Jun 2005 19:26:34 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
Message-ID: <20050602172634.GI23831@wotan.suse.de>
References: <20050602144004.GA31807@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602144004.GA31807@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i've also split up the various spinlock variants into separate files, 
> making it easier to see which does what. The new layout is:

Sigh. You meant more complicated not easier, right?
It is complicated enough now that you would really wish
for an object browser (and a box of aspirin) to read it. But anyways I guess
it was inevitable. 

I would rename __aquire/__release/etc. they are clearly name space
pollution and have even a specific meaning on IA64 which this
does not follow.

-Andi
