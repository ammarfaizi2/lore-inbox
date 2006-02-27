Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWB0M3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWB0M3j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWB0M3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:29:39 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:19876 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751818AbWB0M3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:29:38 -0500
Date: Mon, 27 Feb 2006 17:59:34 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 2/7] Add sysctl for schedstats
Message-ID: <20060227122933.GE22492@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141027367.5785.42.camel@elinux04.optonline.net> <1141027923.5785.50.camel@elinux04.optonline.net> <20060227085203.GB3241@elte.hu> <20060227104634.GB22492@in.ibm.com> <1141042725.2992.96.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141042725.2992.96.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> your sysctl functions sleep. the BKL is useless in the light of sleeping
> code...
>

But wouldn't all sysctls potentially sleep (on account of copying data from
the user).

Thanks for clarifying,
Balbir
