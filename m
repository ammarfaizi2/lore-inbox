Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUIOLkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUIOLkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUIOLku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:40:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26812 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265222AbUIOLkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:40:47 -0400
Date: Wed, 15 Sep 2004 13:38:34 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040915113833.GA4111@suse.de>
References: <20040913015003.5406abae.akpm@osdl.org> <20040915113635.GO9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915113635.GO9106@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, William Lee Irwin III wrote:
> On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> > +cfq-iosched-v2.patch
> >  Major revamp of the CFQ IO scheduler
> 
> While editing some files while booted into 2.6.9-rc1-mm5:
> 
> # ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at cfq_iosched:1359

Hmm, ->allocated is unbalanced. What is your io setup like (adapter,
etc)?

-- 
Jens Axboe

