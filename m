Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266728AbUFYUr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266728AbUFYUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266724AbUFYUrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:47:55 -0400
Received: from [213.146.154.40] ([213.146.154.40]:958 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266728AbUFYUqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:46:53 -0400
Date: Fri, 25 Jun 2004 21:46:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jbarnes@engr.sgi.com, erikj@subway.americas.sgi.com, pfg@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040625204646.GA4343@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, jbarnes@engr.sgi.com,
	erikj@subway.americas.sgi.com, pfg@sgi.com,
	linux-kernel@vger.kernel.org
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <200406251110.07383.jbarnes@engr.sgi.com> <20040625155335.GA30427@infradead.org> <20040625134537.072d17b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040625134537.072d17b9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 01:45:37PM -0700, Andrew Morton wrote:
> I don't think we did that for /dev/kmsg.
> 
> I haven't followed the politics or the history of this much, but if LANANA
> are being unresponsive and/or are ignoring 2.6 kernels, don't we need to
> either fix them up or route around them?

LANANA isn't ignoring 2.6.  Linus mandated they shouldn't accept new
allocations for 2.6 anymore - but given there's very few 2.6-only drivers
this hasn't been much of a problem so far.  Or to quote from
Documentation/devices.txt:

-------------------------------------------------------------------
THE DEVICE REGISTRY IS OFFICIALLY FROZEN FOR LINUS TORVALDS' KERNEL
TREE.  At Linus' request, no more allocations will be made official
for Linus' kernel tree; the 3 June 2001 version of this list is the
official final version of this registry.  At Alan Cox' request,
however, the registry will continue to be maintained for the -ac
series of kernels, and registrations will be accepted.
-------------------------------------------------------------------
