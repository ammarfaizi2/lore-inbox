Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWJJCAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWJJCAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWJJCAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:00:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:12494 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964915AbWJJCAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:00:53 -0400
Subject: Re: faults and signals
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1160445510.32237.50.camel@localhost.localdomain>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
	 <20061009140447.13840.20975.sendpatchset@linux.site>
	 <1160427785.7752.19.camel@localhost.localdomain>
	 <452AEC8B.2070008@yahoo.com.au>
	 <1160442685.32237.27.camel@localhost.localdomain>
	 <452AF546.4000901@yahoo.com.au>
	 <1160445510.32237.50.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 12:00:01 +1000
Message-Id: <1160445601.32237.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes. Tho it's also fairly easy to just add an argument to the wrapper
> and fix all archs... but yeah, I will play around.

Actually, user_mode(ptregs) is standard, we could add a ptregs arg to
the wrapper... or just get rid of it and fix archs, it's not like it was
that hard. There aren't that many callers :)

Is there any reason why we actually need that wrapper ?

Ben.


