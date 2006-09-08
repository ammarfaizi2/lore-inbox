Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWIHHGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWIHHGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWIHHGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:06:18 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:46620 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751896AbWIHHGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:06:17 -0400
Date: Fri, 8 Sep 2006 15:00:11 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Don Mullis <dwm@meer.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: [patch 6/6] process filtering for fault-injection capabilities
Message-ID: <20060908070011.GA8889@miraclelinux.com>
References: <1157696997.9460.99.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157696997.9460.99.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 11:29:57PM -0700, Don Mullis wrote:

> 1) Reorder kernel command line args alphabetically -- lets
> output of `ls /debug/failslab` serve as a handy reminder
> of the arg bindings.
> 
> 2) Rename a variable to agree with the /debug file name.

Yes. this kernel command line was confusing.
This change makes it better.

Now I'm writing the filter which allow failing only for a specific
module by using unwinding kernel stacks API.

Then I'll send next version with your fixes.

