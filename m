Return-Path: <linux-kernel-owner+w=401wt.eu-S1752877AbWLVLeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbWLVLeh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 06:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811AbWLVLeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 06:34:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4228 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752877AbWLVLeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 06:34:36 -0500
Date: Thu, 21 Dec 2006 19:39:03 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Willy Tarreau <w@1wt.eu>, karderio <karderio@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061221193902.GA4268@ucw.cz>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org> <20061216064344.GF24090@1wt.eu> <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org> <20061216164947.GB31013@1wt.eu> <Pine.LNX.4.64.0612160858100.3557@woody.osdl.org> <20061216183301.GA14286@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216183301.GA14286@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Anything else, you have to make some really scary decisions. Can a judge 
>  > decide that a binary module is a derived work even though you didn't 
>  > actually use any code? The real answer is: HELL YES. It's _entirely_ 
>  > possible that a judge would find NVidia and ATI in violation of the GPLv2 
>  > with their modules.
> 
> ATI in particular, I'm amazed their lawyers OK'd stuff like..
> 
> +ifdef STANDALONE
>  MODULE_LICENSE(GPL);
> +endif
> 
> This a paraphrased diff, it's been a while since I've seen it.
> It's GPL if you build their bundled copy of the AGPGART code as agpgart.ko,
> but the usual use case is that it's built-in to fglrx.ko, which sounds
> incredibly dubious.
> 
> Now, AGPGART has a murky past wrt licenses.  It initally was imported
> into the tree with the license "GPL plus additional rights".
> Nowhere was it actually documented what those rights were, but I'm
> fairly certain it wasn't to enable nonsense like the above.
> As it came from the XFree86 folks, it's more likely they really meant
> "Dual GPL/MIT" or similar.
> 
> When I took over, any new code I wrote I explicitly set out to mark as GPL
> code, as my modifications weren't being contributed back to X, they were
> going back to the Linux kernel.  ATI took those AGPv3 modifications from
> a 2.5 kernel, backported them to their 2.4 driver, and when time came

Do they actually distribute that AGPv3 + binary blob? In such case,
you should simply ask them for the binary blob sources, and take them
to the court if they refuse. RedHat should be big enough, and ATI
certainly makes enough money...

They'll probably resolve the problem fast if they feel legal actions
are pending.
							Pavel

-- 
Thanks for all the (sleeping) penguins.
