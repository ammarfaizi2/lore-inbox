Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUBGFdb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbUBGFdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:33:31 -0500
Received: from ns.suse.de ([195.135.220.2]:2015 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265678AbUBGFda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:33:30 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: Manfreds patch to distribute boot allocations across nodes
References: <20040207042559.GP19011@krispykreme.suse.lists.linux.kernel>
	<20040206210428.17ee63db.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Feb 2004 06:33:28 +0100
In-Reply-To: <20040206210428.17ee63db.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p734qu3lahj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:


> > +#ifdef CONFIG_NUMA
> 
> Is this a thing which all NUMA machines want to be doing?

Should be ok yes. The free_pages in zone check should catch the 
32bit NUMAs which only have lowmem in node 0.

I would like to have it for x86-64 too, please.

-Andi
