Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284971AbRLFEsy>; Wed, 5 Dec 2001 23:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284973AbRLFEso>; Wed, 5 Dec 2001 23:48:44 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:6543 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S284971AbRLFEs2>;
	Wed, 5 Dec 2001 23:48:28 -0500
Date: Thu, 6 Dec 2001 05:48:26 +0100
From: David Weinehall <tao@acc.umu.se>
To: Robert Love <rml@tech9.net>
Cc: marcelo@conectiva.com.br, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simple ide without proc compile fix
Message-ID: <20011206054826.Z360@khan.acc.umu.se>
In-Reply-To: <1007594451.28567.18.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1007594451.28567.18.camel@phantasy>; from rml@tech9.net on Wed, Dec 05, 2001 at 06:20:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 06:20:49PM -0500, Robert Love wrote:
> Attached patch is a repost now against 2.4.17-pre4.
> 
> IDE will not compile without CONFIG_PROC_FS defined.  This patch fixes
> that.
> 
> Yes, ifdefs in the code are not preferred.  But this is merely following
> the pattern in the rest of the ide*.c files (see other uses of
> ide_remove_proc_entries -- just these two seem to be without ifdefs).

Wouldn't a dummy, in case of no proc, be preferable? That'd make it
possible to remove all the #ifdef CONFIG_PROC_FS


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
