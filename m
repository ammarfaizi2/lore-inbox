Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVCCL23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVCCL23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVCCLYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:24:07 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:28176 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261630AbVCCLTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:19:52 -0500
Message-ID: <4226F38A.3090408@aitel.hist.no>
Date: Thu, 03 Mar 2005 12:22:50 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>In other words, we'd have an increasing level of instability with an odd 
>release number, depending on how long-term the instability is.
>
> - 2.6.<even>: even at all levels, aim for having had minimally intrusive 
>   patches leading up to it (timeframe: a week or two)
>
>with the odd numbers going like:
>
> - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
>   to it (timeframe: a month or two).
> - 2.<odd>.x: aim for big changes that may destabilize the kernel for 
>   several releases (timeframe: a year or two)
> - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and rewrote
>   the kernel to be a microkernel using a special message-passing version 
>   of Visual Basic. (timeframe: "we expect that he will be released from 
>   the mental institution in a decade or two").
>
>  
>
Fine with me - but I tend to run mm kernels anyway to get the "latest". :-)

Now, if this implies linux 3.0.0 won't ever happen, how about getting
rid of the major number?  It serves no purpose if not used at all. (I don't
consider the VB thing realistic . . .)

Or, if you want to keep the major number for consistency with earlier
kernels, consider:
2.<even>  minimally intrusive patches
2.<odd> big changes needing a month
<odd>.x big changes that destabilize over several releases
2.x.y takes the role 2.x.y.z has today.

Helge Hafting

Helge Hafting
