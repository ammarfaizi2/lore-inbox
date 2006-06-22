Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWFVTW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWFVTW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWFVTW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:22:56 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:37300 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751890AbWFVTWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:22:55 -0400
Date: Thu, 22 Jun 2006 22:22:54 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 2/4] Remove empty destructor from drivers/usb/mon/mon_text.c
In-Reply-To: <20060619184702.23130.11949.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0606222222070.5385@sbz-30.cs.Helsinki.FI>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184702.23130.11949.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Christoph Lameter wrote:
> Remove empty destructor from drivers/usb/mon/mon_text.c
> 
> Remove destructor and call kmem_cache_create with NULL for the destructor.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Looks good.

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

				Pekka
