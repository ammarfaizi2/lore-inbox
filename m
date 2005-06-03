Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFCFln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFCFln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVFCFln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:41:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:38533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261282AbVFCFlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:41:42 -0400
Date: Thu, 2 Jun 2005 22:51:57 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
       Enrique Gaona <egaona@us.ibm.com>
Subject: Re: [ANNOUNCE] automated linux kernel testing results
Message-ID: <20050603055157.GA29447@kroah.com>
References: <531740000.1117749798@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531740000.1117749798@flay>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:03:18PM -0700, Martin J. Bligh wrote:
> OK, I've finally got this to the point where I can publish it.
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> 
> Currently it builds and boots any mainline, -mjb, -mm kernel within
> about 15 minutes of release. runs dbench, tbench, kernbench, reaim and fsx.
> Currently I'm using a 4x AMD64 box, a 16x NUMA-Q, 4x NUMA-Q, 32x x440 (ia32)
> PPC64 Power 5 LPAR, PPC64 Power 4 LPAR, and PPC64 Power 4 bare metal system.
> The config files it uses are linked by the machine names in the column 
> headers.

Nice, very nice, congrats to all involved.

Now, any chance you can do this on the nightly -git snapshots too? :)

And I don't see the -stable releases in there...

thanks,

greg k-h
