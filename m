Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264428AbUESQeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUESQeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUESQeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 12:34:37 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:57870 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264428AbUESQeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 12:34:36 -0400
Date: Wed, 19 May 2004 17:34:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, pfg@sgi.com,
       Erik Jacobson <erikj@sgi.com>
Subject: Re: [PATCH] implement TIOCGSERIAL in sn_serial.c
Message-ID: <20040519173432.A28656@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, pfg@sgi.com,
	Erik Jacobson <erikj@sgi.com>
References: <200405191109.51751.jbarnes@engr.sgi.com> <200405191150.08967.jbarnes@engr.sgi.com> <20040519165618.A28238@infradead.org> <200405191217.13635.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405191217.13635.jbarnes@engr.sgi.com>; from jbarnes@engr.sgi.com on Wed, May 19, 2004 at 12:17:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:17:13PM -0400, Jesse Barnes wrote:
> > And the point of an ioctl copying two values that are compltely irrelevant
> > for userspace with your driver are? [please fill in here]
> 
> What, you think userland isn't interested in the FIFO depth?  Or are you 
> suggesting that we fill in all the values?  Pat?

I want to say this awfully smells like a quickhack.  And your secrecy on
why you need this doesn't help either.  So what userspace needs to know
your fifo depth?

