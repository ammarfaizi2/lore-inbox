Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVDFFsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVDFFsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVDFFsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:48:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37567 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262108AbVDFFsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:48:37 -0400
Date: Wed, 6 Apr 2005 07:48:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 2/5] sched: NULL domains
Message-ID: <20050406054818.GA5977@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <20050406054518.GB5853@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406054518.GB5853@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > 2/5
> 
> > The previous patch fixed the last 2 places that directly access a
> > runqueue's sched-domain and assume it cannot be NULL.
> > 
> > We can now use a NULL domain instead of a dummy domain to signify
> > no balancing is to happen. No functional changes.
> > 
> > Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

if the previous 'remove degenerate domains' patch would go away then 
this patch needs to be merged/modified. (and most of the others as well)

	Ingo
