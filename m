Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTAMJgy>; Mon, 13 Jan 2003 04:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTAMJgy>; Mon, 13 Jan 2003 04:36:54 -0500
Received: from dp.samba.org ([66.70.73.150]:49072 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267725AbTAMJgv>;
	Mon, 13 Jan 2003 04:36:51 -0500
Date: Mon, 13 Jan 2003 20:41:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp?
Message-ID: <20030113094112.GA498@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20030113072521.74B842C104@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113072521.74B842C104@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 06:24:40PM +1100, Paul 'Rusty' Russell wrote:
> Dave: Anton suggested you might have a justification for
> __cacheline_aligned doing something on UP?

It could matter for DMA buffers on UP machines with non-cache coherent
DMA.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
