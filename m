Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbTAGFX2>; Tue, 7 Jan 2003 00:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbTAGFX2>; Tue, 7 Jan 2003 00:23:28 -0500
Received: from vitelus.com ([64.81.243.207]:54795 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S267306AbTAGFX1>;
	Tue, 7 Jan 2003 00:23:27 -0500
Date: Mon, 6 Jan 2003 21:31:52 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an arbitraty piece of memory.
Message-ID: <20030107053152.GF26827@vitelus.com>
References: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 04:03:28PM +1100, Neil Brown wrote:
> I did a little testing and found that on a list of 2 million 
> basenames from a recent backup index (800,000 unique):
> 
>  hash_mem (as included here) is noticably faster than HASH_HALF_MD4 or
>  HASH_TEA: 
> 
>   hash_mem:		10 seconds
>   DX_HASH_HALF_MD4:	14 seconds
>   DX_HASH_TEA:		15.2 seconds

I'm curious how the hash at
http://www.burtleburtle.net/bob/hash/doobs.html would fare. He has a
64-bit version at
http://www.burtleburtle.net/bob/c/lookup8.c.
