Return-Path: <linux-kernel-owner+w=401wt.eu-S1751752AbWLMXgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWLMXgu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWLMXgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:36:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:43438 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbWLMXgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:36:49 -0500
Subject: Re: Bug: early_pfn_in_nid() called when not early
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, cbe-oss-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       Andy Whitcroft <apw@shadowen.org>,
       Michael Kravetz <mkravetz@us.ibm.com>, hch@infradead.org,
       Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061213231717.GC10708@monkey.ibm.com>
References: <200612131920.59270.arnd@arndb.de>
	 <20061213231717.GC10708@monkey.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 10:21:46 +1100
Message-Id: <1166052107.11914.230.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for the debug work!  Just curious if you really need
> CONFIG_NODES_SPAN_OTHER_NODES defined for your platform?  Can you get
> those types of memory layouts?  If not, an easy/immediate fix for you
> might be to simply turn off the option.

Yes, we need that for some pSeries boxes.

Ben.


