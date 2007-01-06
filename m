Return-Path: <linux-kernel-owner+w=401wt.eu-S1751177AbXAFExc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbXAFExc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbXAFExb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:53:31 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:42449 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbXAFExa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:53:30 -0500
Subject: Re: [PATCH] Fix sparsemem on Cell (take 3)
From: John Rose <johnrose@austin.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, External List <linuxppc-dev@ozlabs.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, hch@infradead.org,
       linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
       mkravetz@us.ibm.com, gone@us.ibm.com, cbe-oss-dev@ozlabs.org,
       Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <1168045803.8945.14.camel@localhost.localdomain>
References: <20061215165335.61D9F775@localhost.localdomain>
	 <200612182354.47685.arnd@arndb.de>
	 <1166483780.8648.26.camel@localhost.localdomain>
	 <200612190959.47344.arnd@arndb.de>
	 <1168045803.8945.14.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168059162.23226.1.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 05 Jan 2007 22:52:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I dropped this on the floor over Christmas.  This has had a few smoke
> tests on ppc64 and i386 and is ready for -mm.  Against 2.6.20-rc2-mm1.

Could this break ia64, given that it uses memmap_init_zone()?


