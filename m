Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUBIBvU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUBIBvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:51:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1004 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264549AbUBIBvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:51:18 -0500
Date: Sun, 8 Feb 2004 17:51:07 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, sean.hefty@intel.com,
       linux-kernel@vger.kernel.org, woody@co.intel.com, woody@jf.intel.com
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
 theLinux kernel
Message-Id: <20040208175107.08b84865.zaitcev@redhat.com>
In-Reply-To: <mailman.1076018705.12618.linux-kernel2news@redhat.com>
References: <mailman.1076018705.12618.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 17:02:30 -0500
"Tillier, Fabian" <ftillier@infiniconsys.com> wrote:

> That is absolutely correct.  In addition to portability between kernel
> versions and operating systems, there is also portability between
> user-mode and kernel-mode within a single release.

Just for the record, Robert and Asok visited OLS in 2002 and I seem to
recall explaining to them in excuriating detail why an exact compatibility
between user mode and kernel mode API was a crock of shit, pipe dream,
etc. etc., at least in the context of Linux. Failed to make a dent,
apparently. But at least I tried!

On the other hand, I ate Asok's brain about callbacks until he caved,
so it's not all hopeless. Intel people are competent, they just come from
a different cultural background. I think that instead of plonking it would
be more productive to explain them the issues, e.g. the cost of insane
and atrocious abstractions they have in the stack, that ia64 is not the
only 64 bit architecture in the world (no matter how much Intel wants us
to believe it), that IOMMUs actually exist (in HP's Itanic servers, for
one), such kind of thing.

-- Pete
