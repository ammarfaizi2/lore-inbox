Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWEIPHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWEIPHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWEIPHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:07:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45292 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751350AbWEIPHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:07:04 -0400
Date: Tue, 9 May 2006 16:07:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
Message-ID: <20060509150701.GA14050@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.osdl.org, xen-devel@lists.xensource.com
References: <20060509084945.373541000@sous-sol.org> <4460AC01.5020503@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4460AC01.5020503@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:49:37AM -0700, Martin J. Bligh wrote:
> Congrats on getting this thrashed out. A few comments, most of which are
> boring style nits, but nonetheless ... will try to take a proper look
> later.
> 
> General comment:
> 
> Why is this style used:
> 
> HYPERVISOR_foo_bar ?
> 
> ie the capitalization of HYPERVISOR. Doesn't seem to fit with the rest
> of the kernel style.

It's also wrong.  There's more than one hypervisor and Xen shouldn't just
grab this namespace.  make it xen_ or xenhv_.

