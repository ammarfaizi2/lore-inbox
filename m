Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130140AbQLNST2>; Thu, 14 Dec 2000 13:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLNSTR>; Thu, 14 Dec 2000 13:19:17 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:45540 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S129260AbQLNSTG>; Thu, 14 Dec 2000 13:19:06 -0500
Date: Thu, 14 Dec 2000 18:48:34 +0100
From: David Weinehall <tao@acc.umu.se>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jussi Laako <jussi.laako@imagesoft.fi>, linux-kernel@vger.kernel.org
Subject: Re: Memory subsystem error and freeze on 2.4.0-test12
Message-ID: <20001214184834.A27116@khan.acc.umu.se>
In-Reply-To: <3A38A825.DE416521@imagesoft.fi> <Pine.LNX.4.21.0012141515070.1437-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0012141515070.1437-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Dec 14, 2000 at 03:16:06PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 03:16:06PM -0200, Rik van Riel wrote:
> On Thu, 14 Dec 2000, Jussi Laako wrote:
> 
> > Is this normal:
> > 
> > Dec 14 12:33:32 alien kernel: __alloc_pages: 2-order allocation failed.
> 
> This means that somebody tried to allocate a physically 
> contiguous area of 2^2 = 8 pages, but such an area
> wasn't available.

Ehrm. 2^2 = 4.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
