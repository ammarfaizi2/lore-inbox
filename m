Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUG2C0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUG2C0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUG2C0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:26:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:63917 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267422AbUG2CZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:25:56 -0400
Subject: Re: 2.6.8-rc2-mm1 link errors
From: Dave Hansen <haveblue@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729021225.GG16310@waste.org>
References: <1091057256.2871.637.camel@nighthawk>
	 <20040728164920.5ad4c114.akpm@osdl.org>
	 <1091066773.2871.866.camel@nighthawk>  <20040729021225.GG16310@waste.org>
Content-Type: text/plain
Message-Id: <1091067939.2871.898.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 19:25:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 19:12, Matt Mackall wrote:
> On Wed, Jul 28, 2004 at 07:06:13PM -0700, Dave Hansen wrote:
> > I say, put them back in plain old BSS.  Patch attached.
> 
> Frankly, I'd rather have the warning if it isn't breaking anything.

I just worry that the warning is indicative of something more insidious
than triggering an error from a symbol checker script.

> Or how about I throw some version conditional magic at it?

I thought about including something in compiler-gcc*, but those files
are still pretty simple at this point, and I hate to add more gunk to
them.  It doesn't seem quite worth it to me.  But, if that's the way to
go, I can code it up.

-- Dave

