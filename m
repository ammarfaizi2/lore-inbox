Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVKHS4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVKHS4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVKHS4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:56:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:63156 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030302AbVKHS4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:56:41 -0500
Date: Tue, 8 Nov 2005 10:56:23 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Matthew Dobson <colpatch@us.ibm.com>, kernel-janitors@lists.osdl.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 6/8] Cleanup slabinfo_write()
In-Reply-To: <20051108105013.GA7678@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.62.0511081055430.30907@schroedinger.engr.sgi.com>
References: <436FF51D.8080509@us.ibm.com> <436FF7F7.1060907@us.ibm.com>
 <20051108105013.GA7678@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Alexey Dobriyan wrote:

> On Mon, Nov 07, 2005 at 04:57:27PM -0800, Matthew Dobson wrote:
> > * Set 'res' at declaration instead of later in the function.
> 
> I hate to initialize a varible two miles away from the place where it's
> used.

 
> > -	int limit, batchcount, shared, res;
> > +	int limit, batchcount, shared, res = -EINVAL;

Looks more confusing than before.

