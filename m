Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUJPAzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUJPAzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 20:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJPAzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 20:55:46 -0400
Received: from colin2.muc.de ([193.149.48.15]:37650 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268486AbUJPAzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 20:55:45 -0400
Date: 16 Oct 2004 02:55:44 +0200
Date: Sat, 16 Oct 2004 02:55:44 +0200
From: Andi Kleen <ak@muc.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, KendallB@scitechsoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041016005544.GA75049@muc.de>
References: <20030424075011$4028@gated-at.bofh.it> <1ewKr-2Kh-41@gated-at.bofh.it> <CebL.O9.13@gated-at.bofh.it> <1bucs-57R-33@gated-at.bofh.it> <2PncW-6j9-23@gated-at.bofh.it> <20030423094012$4166@gated-at.bofh.it> <2PncW-6j9-17@gated-at.bofh.it> <2PAMY-7Ir-21@gated-at.bofh.it> <m3655cjc1r.fsf@averell.firstfloor.org> <87u0swouvu.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0swouvu.fsf@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 05:37:09PM +0200, Gerd Knorr wrote:
> Andi Kleen <ak@muc.de> writes:
> 
> > The problem is that this would imply that the console would only
> > work after user space is running. Even with initrd that's quite late.
> 
> klibc + initramfs + early userspace?

That's still quite late in my book (by my perspective may be skewed
a bit from low level architecture hacking) 

Ok I guess for debugging architectures it would work as long as you
have usable early console support everywhere that can be easily 
enabled when anything goes wrong.


-Andi
