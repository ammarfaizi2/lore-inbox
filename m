Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWIAPhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWIAPhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWIAPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:37:21 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:63622 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751639AbWIAPhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:37:19 -0400
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157123046.28577.75.camel@localhost.localdomain>
References: <20060901111006.GE15684@skybase>
	 <1157123046.28577.75.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 17:37:11 +0200
Message-Id: <1157125031.21733.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 08:04 -0700, Dave Hansen wrote:
> > +EXPORT_SYMBOL(find_get_page_nodiscard);
> > +
> > +#endif
> 
> Is it worth having another full copy of find_get_page()?  What about a
> "nodiscard" argument?

That is a hard call to make. I really tried hard to avoid adding any
overhead to a system running without the feature.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


