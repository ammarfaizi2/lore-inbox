Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbQLUDtO>; Wed, 20 Dec 2000 22:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQLUDtF>; Wed, 20 Dec 2000 22:49:05 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:36820 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130645AbQLUDsw>; Wed, 20 Dec 2000 22:48:52 -0500
Date: Thu, 21 Dec 2000 04:18:23 +0100
From: David Weinehall <tao@acc.umu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: fs corruption in 2.4.0-test11?
Message-ID: <20001221041823.A15178@khan.acc.umu.se>
In-Reply-To: <20001220164742.A3756@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001220164742.A3756@work.bitmover.com>; from lm@bitmover.com on Wed, Dec 20, 2000 at 04:47:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 04:47:42PM -0800, Larry McVoy wrote:
> I just need a sanity check - do other pages/blocks sometimes show up in
> recently created files in 2.4.0-test11?

Mmmm. Yes. I think the final fixes for this went into v2.4.0-test12pre5,
but since there's a test13-pre3 out that needs testing, go for that one
directly... :^)

> I have a (so far) non-reproducible case where the wrong data showed up in
> a new file.  The nice part is that it was when I was imploding a large
> BitKeeper patch so I can run the test case over and over if that would 
> help find it.

If you can reproduce it on test13-pre3, we have something to worry
about, if not, feel happy; one bug less to worry about.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
