Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUHBAUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUHBAUW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 20:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUHBAUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 20:20:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13512 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266175AbUHBAUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 20:20:20 -0400
Date: Sun, 1 Aug 2004 21:12:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] problems with modular and nonmodular ide mix
Message-ID: <20040802001201.GA14589@logos.cnet>
References: <20040731150214.GG6497@logos.cnet> <Pine.GSO.4.44.0408011408160.28789-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0408011408160.28789-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 02:09:02PM +0300, Meelis Roos wrote:
> > The thing is cmd640 can't be compiled as a module - just dont
> > use IDE modular if you need cmd640.
> 
> OK, but should CONFIG_BLK_DEV_CMD640 then depend on CONFIG_BLK_DEV_IDE=y
> and show a comment otherwise?

Yep, that sounds good.

But that was not what your patch was trying to do, was it?

Thanks!
