Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264755AbUD2PXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264755AbUD2PXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbUD2PXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:23:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45318 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264755AbUD2PU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:20:27 -0400
Date: Thu, 29 Apr 2004 16:20:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 18 i_mmap_nonlinear
Message-ID: <20040429162020.J16407@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1083246218.1804.1.camel@mulgrave> <Pine.LNX.4.44.0404291516380.5661-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0404291516380.5661-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Apr 29, 2004 at 03:24:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 03:24:03PM +0100, Hugh Dickins wrote:
> > be fine with merging them.
> 
> Great, thanks.  No need for you to refresh me: if I do go ahead with
> merging them (not my current priority), it'll be obvious from whatever
> patch I show against -mm, what change you'd want to make to your tree.

Please go ahead and merge them.  I suspect ARM not scanning i_mmap
is a bug.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
