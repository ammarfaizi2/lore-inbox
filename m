Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWFSNGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWFSNGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWFSNGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:06:14 -0400
Received: from ns1.suse.de ([195.135.220.2]:1211 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932438AbWFSNGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:06:14 -0400
To: Jes Sorensen <jes@sgi.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, Carsten Otte <cotte@de.ibm.com>,
       bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
References: <yq0psh5zenq.fsf@jaguar.mkp.net>
From: Andi Kleen <ak@suse.de>
Date: 19 Jun 2006 15:06:05 +0200
In-Reply-To: <yq0psh5zenq.fsf@jaguar.mkp.net>
Message-ID: <p73r71lpa6a.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> writes:

> Hi,
> 
> I woke up this morning and had a revelation! Today is the day, the day
> of do_no_pfn()! It can be no other way ... :) And what happens, I come
> into the office to discover that 2.6.17 is out! It has to be a sign!
> 
> Anyway, I have had no objections to this patch for a while now,
> clearly it is perfect<tm> :) If anybody has new objections, it's
> obviously not my fault! But ok I'll look at them anyway :)
> 
> So here it is, it even boots!

The big question is - why do you have pages without struct page? 
It seems ... wrong.

-Andi
