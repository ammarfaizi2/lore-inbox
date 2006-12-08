Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424771AbWLHGVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424771AbWLHGVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424770AbWLHGVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:21:34 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:37185 "EHLO
	note.orchestra.cse.unsw.EDU.AU" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1424771AbWLHGVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:21:34 -0500
From: Paul Cameron Davies <pauld@cse.unsw.EDU.AU>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 17:21:24 +1100 (EST)
X-X-Sender: pauld@weill.orchestra.cse.unsw.EDU.AU
cc: David Singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Lee.Schermerhorn@hp.com
Subject: Re: new procfs memory analysis feature
In-Reply-To: <20061207143611.7a2925e2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612081716440.28861@weill.orchestra.cse.unsw.EDU.AU>
References: <45789124.1070207@mvista.com> <20061207143611.7a2925e2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006, Andrew Morton wrote:

> I think that's our eighth open-coded pagetable walker.  Apparently they are
> all slightly different.  Perhaps we shouild do something about that one
> day.

At UNSW we have abstracted the page table into its own layer, and
are running an alternate page table (a GPT), under a clean page table
interface (PTI).

The PTI gathers all the open coded iterators togethers into one place,
which would be a good precursor to providing generic iterators for
non performance critical iterations.

We are completing the updating/enhancements to this PTI for the latest 
kernel, to be released just prior to LCA.  This PTI is benchmarking well. 
We also plan to release the experimental guarded page table (GPT) running 
under this PTI.

Paul Davies
Gelato@UNSW
~

