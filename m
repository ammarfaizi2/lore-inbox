Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSHGBI3>; Tue, 6 Aug 2002 21:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSHGBI3>; Tue, 6 Aug 2002 21:08:29 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:2459 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316609AbSHGBI1>;
	Tue, 6 Aug 2002 21:08:27 -0400
Date: Wed, 7 Aug 2002 11:07:52 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       riel@surriel.com
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <20020807010752.GC6343@krispykreme>
References: <20020806231522.GJ6256@holomorphy.com> <3D506D43.890EA215@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D506D43.890EA215@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> We're piling more and more crap in there to support these pte_chains.
> How much is too much?
> 
> Is it likely that large pages and/or shared pagetables would allow us to
> place pagetables and pte_chains in the direct-mapped region, avoid all
> this?

On ppc64 shared pagetables will require significant changes to the way
we handle the hardware hashtable. So add that to the "more and more crap
in there to support these pte_chains"

Will shared pagetables be a requirement or can we turn it on per arch?

Anton
