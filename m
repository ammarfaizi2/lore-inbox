Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWEIXeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWEIXeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEIXeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:34:37 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20355 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932076AbWEIXef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:34:35 -0400
Date: Tue, 9 May 2006 16:37:32 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Message-ID: <20060509233732.GH24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085201.446830000@sous-sol.org> <20060509115826.GA2213@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509115826.GA2213@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> On Tue, May 09, 2006 at 12:00:34AM -0700, Chris Wright wrote:
> > The network device frontend driver allows the kernel to access network
> > devices exported exported by a virtual machine containing a physical
> > network device driver.
> 
> Please don't add procfs code to new network drivers.  Especially if it's oopsable
> like the code in this driver by simple device renaming.

Agreed, no reason to keep the cruft around.  I thought I had a comment
of the sort in there.

thanks,
-chris
