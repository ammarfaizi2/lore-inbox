Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUCLDOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 22:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUCLDOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 22:14:54 -0500
Received: from colin2.muc.de ([193.149.48.15]:7949 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261930AbUCLDOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 22:14:54 -0500
Date: 12 Mar 2004 04:14:52 +0100
Date: Fri, 12 Mar 2004 04:14:52 +0100
From: Andi Kleen <ak@muc.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040312031452.GA41598@colin2.muc.de>
References: <7F740D512C7C1046AB53446D37200173FEB851@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173FEB851@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 07:04:50PM -0800, Nakajima, Jun wrote:
> As we can have more complex architectures in the future, the scheduler
> is flexible enough to represent various scheduling domains effectively,
> and yet keeps the common scheduler code simple.

I think for SMT alone it's too complex and for NUMA it doesn't do
the right thing for "modern NUMAs" (where NUMA factor is very low
and you have a small number of CPUs for each node). 

-Andi
