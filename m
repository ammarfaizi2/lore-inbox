Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbULGWwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbULGWwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbULGWwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:52:14 -0500
Received: from lakermmtao11.cox.net ([68.230.240.28]:47257 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261926AbULGWwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:52:07 -0500
In-Reply-To: <E1Cbhdi-00085C-00@be1.7eggert.dyndns.org>
References: <fa.gd7ov5r.1n64a8t@ifi.uio.no> <E1Cbhdi-00085C-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9E43B5E2-48A2-11D9-9115-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: krishna <krishna.c@globaledgesoft.com>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: what does __foo means.
Date: Tue, 7 Dec 2004 17:52:06 -0500
To: 7eggert@nurfuerspam.de
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 07, 2004, at 10:52, Bodo Eggert wrote:
> ---http://www.mozilla.org/hacking/portable-cpp.html---
> According to the C++ Standard, 17.4.3.1.2 Global Names 
> [lib.global.names],
> paragraph 1:
>
> Certain sets of names and function signatures are always reserved to 
> the
> implementation:
> Each name that contains a double underscore (__) or begins with an
> underscore followed by an uppercase letter (2.11) is reserved to the
> implemenation for any use.
> Each name that begins with an underscore is reserved to the 
> implementation
> for use as a name in the global namespace.
> ---

The Linux kernel, however, _is_ "the implementation", at least in 
kernel space.
Aside from a very few libgcc functions, almost all symbols are 
available to
kernel developers, though not all are necessarily a good idea. :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


