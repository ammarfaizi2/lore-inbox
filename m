Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268475AbUHLJSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268475AbUHLJSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbUHLJSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:18:16 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17935 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268475AbUHLJSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:18:10 -0400
Date: Thu, 12 Aug 2004 10:18:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: Altix I/O code reorganization - 7 of 21
Message-ID: <20040812101809.E5988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408112329.i7BNTP6F163641@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408112329.i7BNTP6F163641@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Aug 11, 2004 at 06:29:25PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:29:25PM -0500, Pat Gefre wrote:
> Yes, the PCI DMA mapping code is very robust

no.

> and tries to export 
> the many hardware features that are available on our system.  However, not 
> all of these features are "reachable" via the standard Linux PCI mapping 
> interfaces.  We have removed all unreacheable features.  However, we can 
> still support future requirements with these new interfaces when needed.
> 
> Yes, we did look at your patch dated: December 4th 2003.  It was very good, but 

I mean a more recent patch I sent to Colin.

