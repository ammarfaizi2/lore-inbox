Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUCEWf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUCEWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:35:29 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:2439 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261351AbUCEWf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:35:27 -0500
Date: Fri, 5 Mar 2004 14:35:26 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Stuart_Hayes@Dell.com
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Subject: Re: ACPI stack overflow
Message-ID: <20040305223526.GA7425@dingdong.cryptoapps.com>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA1@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA1@ausx2kmpc106.aus.amer.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 03:01:34PM -0600, Stuart_Hayes@Dell.com wrote:

> I think I am getting a stack overflow when Linux is parsing the ACPI
> tables (initializing all the devices and running all the _STA
> methods).  I am using the x86_64 architecture.  I would like to try
> increasing the kernel stack size, but I'm not sure how to go about
> doing this.  Could someone tell me how to increase the kernel stack
> size?  (And, has anyone else seen a problem with stack overflows
> with ACPI?)

Please find the source of the stack overflow and fix that.  Increasing
the kernel stack size is not a suitable solution.


  --cw
