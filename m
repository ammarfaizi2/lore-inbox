Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUHLOsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUHLOsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 10:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268583AbUHLOsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 10:48:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31877 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268582AbUHLOsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 10:48:05 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Altix I/O code reorganization
Date: Thu, 12 Aug 2004 07:47:02 -0700
User-Agent: KMail/1.6.2
Cc: Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <411AAABB.8070707@sgi.com> <20040812101507.C5988@infradead.org>
In-Reply-To: <20040812101507.C5988@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408120747.02508.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 12, 2004 2:15 am, Christoph Hellwig wrote:
> And,  let me repeat:
>
>      There is absolutely _NO_ interest in adding yet another non-standard
>      prom interface for PCI configuration.  IA64 has a standard ACPI-based
>      interface that everyone but SGI implementent.  Please implement that
> one in your firmware.

Our platform does not currently support ACPI based PCI discovery and 
configuration.  My claim is that this patchset gets us closer to being able 
to implement it.  You aren't saying that any changes to the codebase should 
be rejected until ACPI is 100% supported, are you?  That seems like a silly 
stance to take since it precludes incremental improvements in the codebase.

IOW, assuming the patchset meets with general approval in other ways, you 
wouldn't oppose its inclusion just because it doesn't go far enough, would 
you?

Thanks,
Jesse
