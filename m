Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbVLOJ4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbVLOJ4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbVLOJ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:56:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:62336 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1422672AbVLOJ4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:56:03 -0500
Date: Thu, 15 Dec 2005 09:55:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 segfault error codes
In-Reply-To: <20051214195848.GQ23384@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0512150949570.6445@goblin.wat.veritas.com>
References: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com>
 <p73hd9b8r9w.fsf@verdi.suse.de> <8746466a0512141124u68c3f5c9o3411c8af64667d8d@mail.gmail.com>
 <20051214195848.GQ23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Dec 2005 09:55:26.0781 (UTC) FILETIME=[ACB5A6D0:01C6015D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005, Andi Kleen wrote:
> 
> Don't know what kernel you're looking at, but 2.6.15rc5 has
> 
>  *      bit 0 == 0 means no page found, 1 means protection fault
>  *      bit 1 == 0 means read, 1 means write
>  *      bit 2 == 0 means kernel, 1 means user-mode
>  *      bit 3 == 1 means use of reserved bit detected
>  *      bit 4 == 1 means fault was an instruction fetch

I can't see it there in 2.6.15-rc5 or 2.6.15-rc5-git; but it is there
in 2.6.15-rc5-mm3: which seems to contains a lot of x86_64 patches,
perhaps some of which you're expecting already to be in 2.6.15?

Hugh
