Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVCORFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVCORFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVCORFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:05:23 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:59664 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261502AbVCORFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:05:13 -0500
Message-ID: <42370442.7020401@lougher.demon.co.uk>
Date: Tue, 15 Mar 2005 15:50:26 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@engr.sgi.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, mpm@selenic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH][1/2] SquashFS
References: <4235BAC0.6020001@lougher.demon.co.uk>	<20050315003802.GH3163@waste.org>	<42363EAB.3050603@yahoo.com.au> <20050315004759.473f6a0b.pj@engr.sgi.com>
In-Reply-To: <20050315004759.473f6a0b.pj@engr.sgi.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> In the overall kernel (Linus's bk tree) I count:
> 
> 	733 lines matching 'for *( *; *; *)'
> 	718 lines matching 'while *( *1 *)'
> 
> In the kernel/*.c files, I count 15 of the 'for(;;)' style and 1 of the
> 'while(1)' style.
> 
> Certainly the 'for(;;)' style is acceptable, and even slightly to
> substantially dominant, depending on which piece of code you're in.
> 

I prefer the 'while' style, and only used 'for' because that's what I 
thought the kernel used.

If no-one objects I'll change it back to while...

Shouldn't issues like this be in the coding style document?

Phillip

