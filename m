Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUJLP3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUJLP3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUJLP3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:29:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265161AbUJLP1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:27:31 -0400
Date: Tue, 12 Oct 2004 11:27:20 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, <nickpiggin@yahoo.com.au>,
       <linux-mm@kvack.org>
Subject: Re: NUMA: Patch for node based swapping
In-Reply-To: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0410121126390.13693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Christoph Lameter wrote:

> The minimum may be controlled through /proc/sys/vm/node_swap.
> By default node_swap is set to 100 which means that kswapd will be run on
> a zone if less than 10% are available after allocation.

That sounds like an extraordinarily bad idea for eg. AMD64
systems, which have a very low numa factor.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

