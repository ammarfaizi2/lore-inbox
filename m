Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUHLPV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUHLPV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUHLPV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 11:21:57 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:6404 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268589AbUHLPVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 11:21:25 -0400
Date: Thu, 12 Aug 2004 16:21:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Patrick Gefre <pfg@sgi.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code reorganization
Message-ID: <20040812162123.A2145@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Patrick Gefre <pfg@sgi.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <411AAABB.8070707@sgi.com> <20040812101507.C5988@infradead.org> <200408120747.02508.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408120747.02508.jbarnes@engr.sgi.com>; from jbarnes@engr.sgi.com on Thu, Aug 12, 2004 at 07:47:02AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 07:47:02AM -0700, Jesse Barnes wrote:
> Our platform does not currently support ACPI based PCI discovery and 
> configuration.  My claim is that this patchset gets us closer to being able 
> to implement it.  You aren't saying that any changes to the codebase should 
> be rejected until ACPI is 100% supported, are you?  That seems like a silly 
> stance to take since it precludes incremental improvements in the codebase.

Changes to the codebase are just fine.  Adding new interface to the prom
the duplicate the standard interface for that prupose on IA64 are not fine.

