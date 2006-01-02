Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWABMp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWABMp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWABMp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:45:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:50120 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750705AbWABMp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:45:59 -0500
From: Andi Kleen <ak@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Date: Mon, 2 Jan 2006 13:45:44 +0100
User-Agent: KMail/1.8.2
Cc: Denis Vlasenko <vda@ilport.com.ua>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <84144f020601020037n7af7ac54l74cdbe602372c7f@mail.gmail.com>
In-Reply-To: <84144f020601020037n7af7ac54l74cdbe602372c7f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601021345.44843.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 09:37, Pekka Enberg wrote:
> On 12/28/05, Andreas Kleen <ak@suse.de> wrote:
> > I remember the original slab paper from Bonwick actually mentioned that
> > power of two slabs are the worst choice for a malloc - but for some reason Linux
> > chose them anyways.
> 
> Power of two sizes are bad because memory accesses tend to concentrate
> on the same cache lines but slab coloring should take care of that. So
> I don't think there's a problem with using power of twos for kmalloc()
> caches.

There is - who tells you it's the best possible distribution of memory? 

-Andi


