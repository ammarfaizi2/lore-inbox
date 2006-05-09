Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWEIIMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWEIIMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWEIIMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:12:34 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:39631 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751458AbWEIIMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:12:34 -0400
Date: Tue, 9 May 2006 13:38:49 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [updated] [Patch 5/8] taskstats interface
Message-ID: <20060509080849.GC11533@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061829.GB22607@in.ibm.com> <20060504184011.GB6966@in.ibm.com> <20060508143139.2f1c7623.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508143139.2f1c7623.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:31:39PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > +
> > +	if ((rc = genl_register_ops(&family, &taskstats_ops)) < 0)
> > +		goto err;
> 
> 	rc = genl_register_ops(&family, &taskstats_ops);
> 	if (rc < 0)
> 		goto err;
> 
> please.

Will follow the new style.

	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
