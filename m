Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbTIYH10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTIYH10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:27:26 -0400
Received: from holomorphy.com ([66.224.33.161]:9099 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261734AbTIYH1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:27:25 -0400
Date: Thu, 25 Sep 2003 00:25:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, neilb@cse.unsw.edu.au, braam@clusterfs.com,
       davem@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, tridge@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl-controlled number of groups.
Message-ID: <20030925072502.GL4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, akpm@zip.com.au,
	neilb@cse.unsw.edu.au, braam@clusterfs.com, davem@redhat.com,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	David Mosberger-Tang <davidm@hpl.hp.com>, tridge@samba.org,
	linux-kernel@vger.kernel.org
References: <20030925035943.AE41C2C04B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925035943.AE41C2C04B@lists.samba.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:21:01PM +1000, Rusty Russell wrote:
> We have a client (using SAMBA) who has people in 190 groups.  Since NT
> has hierarchical groups, this is not all that rare.
> What do people think of this patch?

I like the idea of raising the microscopic limit. BTW, was the Author:
supposed to be Tim Hockin? ISTR his writing this or something almost
identical to it. Also, I'm not sure if the sysctl is worth anything.


-- wli
