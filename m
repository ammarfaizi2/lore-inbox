Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVFCFpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVFCFpe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFCFpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:45:33 -0400
Received: from dvhart.com ([64.146.134.43]:17575 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261257AbVFCFpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:45:11 -0400
Date: Thu, 02 Jun 2005 22:45:13 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
       Enrique Gaona <egaona@us.ibm.com>
Subject: Re: [ANNOUNCE] automated linux kernel testing results
Message-ID: <358650000.1117777512@[10.10.2.4]>
In-Reply-To: <20050603055157.GA29447@kroah.com>
References: <531740000.1117749798@flay> <20050603055157.GA29447@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Greg KH <greg@kroah.com> wrote (on Thursday, June 02, 2005 22:51:57 -0700):

> On Thu, Jun 02, 2005 at 03:03:18PM -0700, Martin J. Bligh wrote:
>> OK, I've finally got this to the point where I can publish it.
>> 
>> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
>> 
>> Currently it builds and boots any mainline, -mjb, -mm kernel within
>> about 15 minutes of release. runs dbench, tbench, kernbench, reaim and fsx.
>> Currently I'm using a 4x AMD64 box, a 16x NUMA-Q, 4x NUMA-Q, 32x x440 (ia32)
>> PPC64 Power 5 LPAR, PPC64 Power 4 LPAR, and PPC64 Power 4 bare metal system.
>> The config files it uses are linked by the machine names in the column 
>> headers.
> 
> Nice, very nice, congrats to all involved.
> 
> Now, any chance you can do this on the nightly -git snapshots too? :)
> 
> And I don't see the -stable releases in there...

It does do both. I just didn't pull in all the historical data, I just
repopulated the external set with a brief snapshot (I have way more
internally, but it has some crap unpublishable benchmarks in it).
If you look at the latest rev, about 3 up it has 2.6.12-rc5-git7, and
I think I've fixed it to monitor for new ones automatically now.
I guess we'll see if it worked in the morning ;-)

M.




