Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135472AbRAGCgo>; Sat, 6 Jan 2001 21:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135603AbRAGCgh>; Sat, 6 Jan 2001 21:36:37 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:50902 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S135472AbRAGCgP>; Sat, 6 Jan 2001 21:36:15 -0500
Date: Sun, 7 Jan 2001 03:36:11 +0100
From: David Weinehall <tao@acc.umu.se>
To: Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>
Cc: "Linux-kernel's Mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: Little question about modules...
Message-ID: <20010107033611.B2127@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.21.0101140318240.5780-100000@the-babel-tower.nobis.phear.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0101140318240.5780-100000@the-babel-tower.nobis.phear.org>; from Pixel@the-babel-tower.nobis.phear.org on Sun, Jan 14, 2001 at 03:20:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 03:20:52AM +0100, Nicolas Noble wrote:
> 
> Just a question:
> 
> Why do I have used by -1 for the module ipv6 onto my system?
> 
> extract of the /proc/modules:
> 
> ip6table_filter         1988   0 (unused)
> ip6t_mark                688   0 (unused)
> ip6t_limit              1016   0 (unused)
> ip6_tables             13044   3 [ip6table_filter ip6t_mark ip6t_limit]
> ipv6                  117992  -1

To make sure ipv6 can't get unloaded. If I remember correctly, the
ipv6 code will oops nicely if unloaded.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
