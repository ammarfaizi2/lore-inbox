Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVDFFvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVDFFvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVDFFvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:51:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9897 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262111AbVDFFvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:51:35 -0400
Date: Wed, 6 Apr 2005 07:45:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 2/5] sched: NULL domains
Message-ID: <20050406054518.GB5853@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42532317.5000901@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> 2/5

> The previous patch fixed the last 2 places that directly access a
> runqueue's sched-domain and assume it cannot be NULL.
> 
> We can now use a NULL domain instead of a dummy domain to signify
> no balancing is to happen. No functional changes.
> 
> Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
