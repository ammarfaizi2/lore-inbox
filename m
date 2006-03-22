Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWCVT0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWCVT0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWCVT0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:26:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6016 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932406AbWCVT0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:26:17 -0500
Date: Wed, 22 Mar 2006 11:26:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 10/35] Add a new head.S start-of-day file for booting on Xen.
Message-ID: <20060322192636.GB15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <200603221443.54119.ak@suse.de> <20060322185836.GZ15997@sorel.sous-sol.org> <200603221945.35113.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221945.35113.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Wednesday 22 March 2006 19:58, Chris Wright wrote:
> > There's still kernel/user cs/ds in gdt, so it's not all zero.
> 
> Make them symbol with a common macro then.

To fill entries as defined by subarch?  That should work.

thanks,
-chris
