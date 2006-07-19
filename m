Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWGSFaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWGSFaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWGSFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 01:30:11 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:62849 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932502AbWGSFaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 01:30:09 -0400
Date: Tue, 18 Jul 2006 22:30:34 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [RFC PATCH 16/33] Add support for Xen to entry.S.
Message-ID: <20060719053034.GH2654@sequoia.sous-sol.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091952.505770000@sous-sol.org> <1153250220.5467.38.camel@localhost.localdomain> <20060718204333.GD2654@sequoia.sous-sol.org> <44BD68B1.2060508@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BD68B1.2060508@goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> It might be an idea to use something other than STI, CLI and CPUID, 
> since the assembler is case-insensitive.  We've already had one bug 
> where CPUID didn't get replaced and the assembler quietly accepted it as-is.

Yes, having been bitten by that, I'd have to second that.

thanks,
-chris
