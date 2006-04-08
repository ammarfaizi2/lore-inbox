Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWDHAZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWDHAZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 20:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWDHAZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 20:25:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:33679 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751378AbWDHAZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 20:25:42 -0400
Subject: Re: 2.6.17-rc1-mm1 - detects buggy TSC on GEODE
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060407170706.1ae11ea1.akpm@osdl.org>
References: <20060404014504.564bf45a.akpm@osdl.org>
	 <4436D275.2010402@gmail.com>  <20060407170706.1ae11ea1.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 17:25:44 -0700
Message-Id: <1144455945.16269.3.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 17:07 -0700, Andrew Morton wrote:
> Jim Cromie <jim.cromie@gmail.com> wrote:
> > as the 2 syslog extracts show;
> > 1.   the new kernel is now detecting the buggy TSC on the GEODE-sc1100
> > 2.    the bug is apparently correctable by passing 'idle=poll' on kernel 
> > boot-line.
>
> John, does this mean that enable-tsc-for-amd-geode-gx-lx.patch is only safe
> to merge after all your time-management patches have gone in?

Hmmm. That would look to be the case from Jim's mail, although I'm not
very familiar with the hardware in question, so I could be wrong. 

thanks
-john

