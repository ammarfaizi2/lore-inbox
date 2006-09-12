Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWILHaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWILHaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWILHaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:30:55 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:44984 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751389AbWILHaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:30:55 -0400
Date: Tue, 12 Sep 2006 15:08:13 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Don Mullis <dwm@meer.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: [patch 6/6] process filtering for fault-injection capabilities
Message-ID: <20060912070813.GA20802@miraclelinux.com>
References: <1157696997.9460.99.camel@localhost.localdomain> <20060908070011.GA8889@miraclelinux.com> <1157825698.9460.110.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157825698.9460.110.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 11:14:58AM -0700, Don Mullis wrote:
> On Fri, 2006-09-08 at 15:00 +0800, Akinobu Mita wrote:
> > Now I'm writing the filter which allow failing only for a specific
> > module by using unwinding kernel stacks API.
> 
> Are you planning to use STACK_UNWIND?  I see that only i386
> supports STACK_UNWIND.
> 
> Perhaps the much simpler STACKTRACE would suffice -- supported
> by i386, x86_64, and s390?

Thanks, I didn't realize the include/linux/stacktrace.h

