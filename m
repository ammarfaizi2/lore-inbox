Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbUKJWGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbUKJWGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 17:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUKJWGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 17:06:12 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:21440 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262061AbUKJWGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 17:06:10 -0500
Date: Wed, 10 Nov 2004 15:06:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <galak@somerset.sps.mot.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][PPC32] Update cpu_spec for performance monitor counters, C99, and e500 userland CPU features
Message-ID: <20041110220608.GB26631@smtp.west.cox.net>
References: <Pine.LNX.4.61.0411092016370.16462@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411092016370.16462@blarg.somerset.sps.mot.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 08:30:43PM -0600, Kumar Gala wrote:

> Andrew,
> 
> This patch replaces the previous patch for adding performance monitor 
> counters to cpu_spec.
> 
> -
> 
> Adds the number of performance monitor counters on each PowerPC processor 
> has to the cpu table.  Makes oprofile support a bit cleaner since we dont 
> need a case statement on processor version to determine the number of 
> counters.
> 
> Reformatted cpu_spec to use C99 initialization.
> 
> Added userland CPU features for SPE, Embedded Floating Point Single 
> precision, and Embedded Floating Point Double precision on e500.
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com> 
[snip]

Now that we're doing C99 inits, can we just drop the empty fields
finally (And if __setup_cpu_8xx really is empty, just kill it) ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
