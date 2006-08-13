Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWHMF46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWHMF46 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 01:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWHMF46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 01:56:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750702AbWHMF45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 01:56:57 -0400
Date: Sat, 12 Aug 2006 22:56:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Message-ID: <20060812225646.73b1ac2b@localhost.localdomain>
In-Reply-To: <20060812181603.GA31106@edgar.underground.se.axis.com>
References: <200608121207.42268.rjw@sisk.pl>
	<200608121631.18603.rjw@sisk.pl>
	<20060812161253.GA30691@edgar.underground.se.axis.com>
	<200608121913.01139.rjw@sisk.pl>
	<20060812181603.GA31106@edgar.underground.se.axis.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2006 20:16:03 +0200
"Edgar E. Iglesias" <edgar.iglesias@axis.com> wrote:

> On Sat, Aug 12, 2006 at 07:13:01PM +0200, Rafael J. Wysocki wrote:
> > Apparently it doesn't.
> 
> Hi, could you try and see if this helps?
> 
> Best regards

That looks good, but needs a few more changes for full safety.
Kind of like the sky2 changes needed to get Mac Mini to work.

The machine I have with skge boards don't suspend right but that is because
of other problems.
