Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRBUOJn>; Wed, 21 Feb 2001 09:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbRBUOJd>; Wed, 21 Feb 2001 09:09:33 -0500
Received: from nnj-dialup-61-19.nni.com ([216.107.61.19]:6336 "EHLO
	nnj-dialup-61-19.nni.com") by vger.kernel.org with ESMTP
	id <S129216AbRBUOJT>; Wed, 21 Feb 2001 09:09:19 -0500
Date: Wed, 21 Feb 2001 09:06:44 -0500 (EST)
From: TenThumbs <tenthumbs@cybernex.net>
Reply-To: TenThumbs <tenthumbs@cybernex.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [lkml]2.2.19pre13: Are there network problem with a low-bandwidth
 link?
In-Reply-To: <E14VC5A-0006YY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102210904390.151-100000@perfect.master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Alan Cox wrote:

> 
> Its normal tcp behaviour. Its something called the capture effect. You can
> mitigate it to an extent by using less buffers, but the buffer count in question
> is at the ISP end for a download, or by using smaller windows
> 

Some dumb questions.

Does this explain why the kernel sees bad segments? Do you know what
changed between pre8 and pre10 so that I can undo it? Exactly which
windows should be smaller?

Thanks.

-- 
Pluto
    2001-02-21 14:04:40.621 UTC (JD 2451962.086581)
    X  =  -8.608189699, Y  = -28.428478747, Z  =  -6.278034413 (au)
    X' =   0.003075244, Y' =  -0.001008929, Z' =  -0.001241413 (au/d)

