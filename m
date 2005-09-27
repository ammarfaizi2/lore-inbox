Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVI0AQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVI0AQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVI0AQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 20:16:47 -0400
Received: from smtpout.mac.com ([17.250.248.70]:39925 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964778AbVI0AQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 20:16:46 -0400
In-Reply-To: <43385412.5080506@austin.ibm.com>
References: <4338537E.8070603@austin.ibm.com> <43385412.5080506@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21024267-29C3-4657-9C45-17D186EAD808@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/9] add defrag flags
Date: Mon, 26 Sep 2005 20:16:03 -0400
To: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2005, at 16:03:30, Joel Schopp wrote:
> The flags are:
> __GFP_USER, which corresponds to easily reclaimable pages
> __GFP_KERNRCLM, which corresponds to userspace pages

Uhh, call me crazy, but don't those flags look a little backwards to  
you?  Maybe it's just me, but wouldn't it make sense to expect  
__GFP_USER to be a userspace allocation and __GFP_KERNRCLM to be an  
easily reclaimable kernel page?

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+ 
++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


