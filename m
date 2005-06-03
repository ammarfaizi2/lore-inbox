Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFCGDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFCGDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 02:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVFCGDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 02:03:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:23694 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261337AbVFCGDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 02:03:04 -0400
Date: Thu, 2 Jun 2005 23:13:21 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
       Enrique Gaona <egaona@us.ibm.com>
Subject: Re: [ANNOUNCE] automated linux kernel testing results
Message-ID: <20050603061321.GB29685@kroah.com>
References: <531740000.1117749798@flay> <20050603055157.GA29447@kroah.com> <358650000.1117777512@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358650000.1117777512@[10.10.2.4]>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 10:45:13PM -0700, Martin J. Bligh wrote:
> 
> 
> --Greg KH <greg@kroah.com> wrote (on Thursday, June 02, 2005 22:51:57 -0700):
> 
> > On Thu, Jun 02, 2005 at 03:03:18PM -0700, Martin J. Bligh wrote:
> >> OK, I've finally got this to the point where I can publish it.
> >> 
> >> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> >> 
> >> Currently it builds and boots any mainline, -mjb, -mm kernel within
> >> about 15 minutes of release. runs dbench, tbench, kernbench, reaim and fsx.
> >> Currently I'm using a 4x AMD64 box, a 16x NUMA-Q, 4x NUMA-Q, 32x x440 (ia32)
> >> PPC64 Power 5 LPAR, PPC64 Power 4 LPAR, and PPC64 Power 4 bare metal system.
> >> The config files it uses are linked by the machine names in the column 
> >> headers.
> > 
> > Nice, very nice, congrats to all involved.
> > 
> > Now, any chance you can do this on the nightly -git snapshots too? :)
> > 
> > And I don't see the -stable releases in there...
> 
> It does do both. I just didn't pull in all the historical data, I just
> repopulated the external set with a brief snapshot (I have way more
> internally, but it has some crap unpublishable benchmarks in it).
> If you look at the latest rev, about 3 up it has 2.6.12-rc5-git7, and
> I think I've fixed it to monitor for new ones automatically now.

Ah, sorry about that, you are correct, I missed it while seeing all of
the -mm releases in there :)

thanks,

greg k-h
