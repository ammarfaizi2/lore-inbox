Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWCVAY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWCVAY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWCVAY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:24:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33514 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751867AbWCVAY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:24:28 -0500
Date: Tue, 21 Mar 2006 16:24:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       penberg@cs.helsinki.fi
Subject: Re: slab: Add transfer_objects() function
In-Reply-To: <20060321162124.07361de2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603211624040.14503@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603211509180.14245@schroedinger.engr.sgi.com>
 <20060321162124.07361de2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > +static int transfer_objects(struct array_cache *to,
> > +		struct array_cache *from, int max)
> 
> Does this ever get called if !CONFIG_NUMA?

Yes. See later in the patch.
