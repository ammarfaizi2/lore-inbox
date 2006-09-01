Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWIAPd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWIAPd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWIAPd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:33:26 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:56712 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751599AbWIAPdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:33:25 -0400
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157122713.28577.71.camel@localhost.localdomain>
References: <20060901111006.GE15684@skybase>
	 <1157122713.28577.71.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 17:33:22 +0200
Message-Id: <1157124802.21733.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 07:58 -0700, Dave Hansen wrote:
> > +#if defined(CONFIG_PAGE_STATES)
> 
> This is a bit odd.  Why not use an #ifdef like the rest of the kernel?

Personal preference I guess. If you have multiple macros you want to
test for you need to use "#if defined(a) && defined(b)", there is no
equivalent #ifndef notation.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


