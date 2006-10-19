Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423020AbWJSQ51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423020AbWJSQ51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423021AbWJSQ51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:57:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:5813 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423020AbWJSQ51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:57:27 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm1
Date: Thu, 19 Oct 2006 18:57:19 +0200
User-Agent: KMail/1.9.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
References: <20061016230645.fed53c5b.akpm@osdl.org> <p73r6x4bi5w.fsf@verdi.suse.de> <20061019091816.e04ae8e7.akpm@osdl.org>
In-Reply-To: <20061019091816.e04ae8e7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191857.19150.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> What is the reason for not using an apic/lapic NMI source for the watchdog?

That is nmi_watchdog=2. But then the watchdog would run at full HZ frequency and 
use a lot of CPU time unnecessarily

-Andi
