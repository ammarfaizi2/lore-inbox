Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSLDNCz>; Wed, 4 Dec 2002 08:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLDNCz>; Wed, 4 Dec 2002 08:02:55 -0500
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:17129 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S266480AbSLDNCy>; Wed, 4 Dec 2002 08:02:54 -0500
Date: Wed, 4 Dec 2002 14:10:25 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate use of bdflush()
Message-ID: <20021204131024.GA3428@neljae>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com> <1038935401.994.9.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038935401.994.9.camel@phantasy>
User-Agent: Mutt/1.4i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 12:10:01PM -0500, Robert Love wrote:
> 2.4 does not need bdflush, either.
> 
> Bdflush the user-space daemon went away a long time ago, ~1995.

sys_bdflush() is still usable in 2.4 to tune kupdated's parameters.
Only func==1 functionality is long gone.

> Besides, you only see the message once for each daemon that is loaded. 
> So regardless of the rate limiting you probably only see it once on
> boot.

And each time you try to twist the flushing parameters.

Regards,

Daniel.

