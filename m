Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbUDSGtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUDSGtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:49:46 -0400
Received: from holomorphy.com ([207.189.100.168]:34450 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263302AbUDSGtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:49:45 -0400
Date: Sun, 18 Apr 2004 23:49:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040419064943.GF743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	pj@sgi.com
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419062914.GE743@holomorphy.com> <20040418234214.7bfb5392.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040418234214.7bfb5392.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 11:42:14PM -0700, Andrew Morton wrote:
> I confess to being moderately exhasperated at the amount of talk and
> patching going on in the bitmap and cpumask areas.  So when your patch
> floated past with a terse description which was bristling with ifs, buts
> and maybes I decided to take a pass.  
> If you want to send it again, cc'ing your co-conspirators and imparting some
> confidence that this darned thing is actually meandering toward a conclusion,
> please feel free ;)

Quick story is that what I sent is (what I believe) to be the bare
minimum change to restore correctnes.

I'll start arguing with people to make sure bugfixes start moving and
cleanups start waiting.

Paul, please remove akpm from the cc: list in future replies until we
have come to a consensus and get this nailed down (hopefully ASAP) to
a coherent cross-vendor story.

What I believe I have sent is the bare minimum change, with no cleanups
or semantic changes. If you could review and/or send approval or the
like that would be very helpful for the users of small SMP systems who
are affected by the bug(s) you reported.


-- wli
