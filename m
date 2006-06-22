Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbWFVTqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWFVTqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbWFVTqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:46:52 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:23506 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161222AbWFVTqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:46:51 -0400
Date: Thu, 22 Jun 2006 22:46:50 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] Slab Reclaim logic
In-Reply-To: <Pine.LNX.4.64.0606221243360.31332@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0606222246160.5385@sbz-30.cs.Helsinki.FI>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222234400.5385@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0606221243360.31332@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Christoph Lameter wrote:
> > s/nr_freed/ret/
> 
> ret is non descriptive. nr_freed is describing what the purpose of the 
> variable is.
> 
> > > +	while (nr_freed < slabs_to_free) {
> > > +		int x;
> > 
> > s/x/nr_freed/
> 
> Would shadow variable.

Which is why I suggested using ret for the return variable.  Not a biggie, 
though, obviously.

				Pekka
