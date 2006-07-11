Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWGKNOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWGKNOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWGKNOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:14:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750747AbWGKNOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:14:43 -0400
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change
	pstate at same time
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Joachim Deguara <joachim.deguara@amd.com>,
       Mark Langsdorf <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
In-Reply-To: <200607111507.39079.ak@suse.de>
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com>
	 <p73fyhdpqe1.fsf@verdi.suse.de> <1152622554.4489.32.camel@lapdog.site>
	 <200607111507.39079.ak@suse.de>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 15:14:35 +0200
Message-Id: <1152623675.3128.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The only way to possibly make the concept work would be regular TSC resyncs
> during runtime, but I think I would prefer using per CPU TSC offsets
> using RDTSCP instead because they should be able to tolerate arbitary
> shifts.

if you have per cpu offset and speed, then you don't even need to tie
all frequencies together... sounds like the best solution to me..

