Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbREBKxN>; Wed, 2 May 2001 06:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbREBKxD>; Wed, 2 May 2001 06:53:03 -0400
Received: from ns.suse.de ([213.95.15.193]:7685 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132580AbREBKwv>;
	Wed, 2 May 2001 06:52:51 -0400
Date: Wed, 2 May 2001 12:52:43 +0200
From: Andi Kleen <ak@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Ville Herva <vherva@mail.niksula.cs.hut.fi>,
        Fabio Riccardi <fabio@chromium.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010502125243.A518@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sat, Apr 28, 2001 at 04:56:27PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for the late answer -- i was involuntarily offline for a few days]

On Sat, Apr 28, 2001 at 04:56:27PM -0600, Richard Gooch wrote:
> Whatever happened to that hack that was discussed a year or two ago?
> The one where (also on IA32) a magic page was set up by the kernel
> containing code for fast system calls, and the kernel would write
> calibation information to that magic page. The code written there
> would use the TSC in conjunction with that calibration data.
> 
> There was much discussion about this idea, even Linus was keen on
> it. But IIRC, nothing ever happened.

It's already implemented in the x86-64 port, thanks to Andrea
Arcangelli.

-Andi
