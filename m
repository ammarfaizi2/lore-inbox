Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUIKKuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUIKKuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUIKKuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:50:20 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:49673 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268101AbUIKKuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:50:17 -0400
Date: Sat, 11 Sep 2004 11:50:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: device driver for the SGI system clock, mmtimer
Message-ID: <20040911115002.B1053@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409082058140.28678@schroedinger.engr.sgi.com> <20040908210537.585120c1.akpm@osdl.org> <Pine.LNX.4.58.0409082210230.29080@schroedinger.engr.sgi.com> <200409082343.21330.jbarnes@engr.sgi.com> <Pine.LNX.4.58.0409101251400.9101@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409101251400.9101@schroedinger.engr.sgi.com>; from clameter@sgi.com on Fri, Sep 10, 2004 at 12:54:30PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 12:54:30PM -0700, Christoph Lameter wrote:
> On Wed, 8 Sep 2004, Jesse Barnes wrote:
> > We may as well kill anything under MMTIMER_INTERRUPT_SUPPORT.  IIRC, people
> > use SHub timer interrupts, but not via this driver.  If you want to fix it,
> > that's ok too, but you can kill the #ifdef in that case also.
> 
> Here is the driver with the interrupt support "killed". Hope this is
> enough to get it into the kernel, Andrew? I did not get any other
> feedback:

please at least kill all the userland gunk from mmtmer.h

