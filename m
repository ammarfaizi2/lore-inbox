Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbULHVnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbULHVnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbULHVnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:43:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:7365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261374AbULHVm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:42:58 -0500
Date: Wed, 8 Dec 2004 13:42:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: Christoph Lameter <clameter@sgi.com>, jbarnes@engr.sgi.com,
       nickpiggin@yahoo.com.au, jgarzik@pobox.com, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
In-Reply-To: <20041208132627.1c73177e.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0412081341230.31040@ppc970.osdl.org>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <20041202101029.7fe8b303.cliffw@osdl.org> <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
 <200412080933.13396.jbarnes@engr.sgi.com> <Pine.LNX.4.58.0412080952100.27324@schroedinger.engr.sgi.com>
 <20041208132627.1c73177e.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Dec 2004, David S. Miller wrote:
> 
> I see.  Yet I noticed that while the patch makes system time decrease,
> for some reason the wall time is increasing with the patch applied.
> Why is that, or am I misreading your tables?

I assume that you're looking at the final "both patches applied" case.

It has ten repetitions, while the other two tables only have three. That 
would explain the discrepancy.

		Linus
