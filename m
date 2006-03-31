Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWCaGKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWCaGKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWCaGKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:10:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37763 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751000AbWCaGKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:10:01 -0500
Date: Thu, 30 Mar 2006 22:10:37 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
Message-ID: <20060331061037.GD14724@sorel.sous-sol.org>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com> <ed5aea430603301642t283174f6wa0587089920ca3a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5aea430603301642t283174f6wa0587089920ca3a8@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Mosberger-Tang (David.Mosberger@acm.org) wrote:
> I have to agree with Hans and I'd much prefer making the mode part of
> the operation's
> name and not a parameter.  Besides being The Right Thing, it saves a
> lot of typing.
> For example:
> 
> +       set_bit_mode(nr, addr, MODE_ATOMIC);
> 
> would simply become
> 
> +       set_bit_atomic(nr, addr);

That's the approach Xen took as well.

thanks,
-chris
