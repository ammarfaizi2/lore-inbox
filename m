Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVAaU3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVAaU3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVAaU3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:29:38 -0500
Received: from lakermmtao02.cox.net ([68.230.240.37]:35064 "EHLO
	lakermmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261327AbVAaU3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:29:36 -0500
In-Reply-To: <41FE2814.9030503@tiscali.de>
References: <41FE1B4B.2060305@tiscali.de> <200501311157.10932.mbuesch@freenet.de> <41FE2814.9030503@tiscali.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D25F0ABA-73C6-11D9-B5F9-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Michael Buesch <mbuesch@freenet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: My System doesn't use swap!
Date: Mon, 31 Jan 2005 15:29:35 -0500
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 31, 2005, at 07:44, Matthias-Christian Ott wrote:
> Ok maybe I wasn't able to read the /free/ output correctly, but why is 
> no
> swap used (more than 60% ram are used)?

Swap is orders of magnitude slower than RAM. Why put things there if you
still have RAM left?  The kernel only puts things in swap when it has no
more RAM _and_ has already deleted big chunks of its disk cache.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


