Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTEFHFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbTEFHFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:05:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:60574 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262413AbTEFHFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:05:34 -0400
Date: Tue, 6 May 2003 12:50:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030506072053.GA9226@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030505220250.213417f6.akpm@digeo.com> <20030505.211606.28803580.davem@redhat.com> <20030505224815.07e5240c.akpm@digeo.com> <20030505.223554.88485673.davem@redhat.com> <20030505235549.5df75866.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505235549.5df75866.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 11:55:49PM -0700, Andrew Morton wrote:
> > I also don't see how this fits in for your ext2 fuzzy counter stuff.
> 
> Well it doesn't fit.  With the proposals which we are discussing here, ext2
> (and, we hope, soon ext3) would continue to use foo[NR_CPUS].

And that is not what we want to do in a NUMA box.

Thanks
Dipankar
