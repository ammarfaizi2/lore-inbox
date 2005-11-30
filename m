Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVK3RHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVK3RHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVK3RHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:07:10 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:51163 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751459AbVK3RHI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:07:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M9ukWvxzUy7l6mFA8vBGiElYi/xMwGqNIOyQmKG0CBbTf9Ofpdw/mglp6HU6qz3rSr+RN4/s5ScxthugoKbXsfh5JwGTPeHGIgXSMfFfSt0orIlyINfq2gLnD8+GcE6HuS10kw8Ssd2R/tVwN+AyG79hLSLN/RMpnORZrErF6JA=
Message-ID: <cda58cb80511300907y7b39e001w@mail.gmail.com>
Date: Wed, 30 Nov 2005 18:07:07 +0100
From: Franck <vagabon.xyz@gmail.com>
To: Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
In-Reply-To: <20051130165546.GD1053@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511300821y72f3354av@mail.gmail.com>
	 <20051130162327.GC1053@flint.arm.linux.org.uk>
	 <cda58cb80511300845j18c81ce6p@mail.gmail.com>
	 <20051130165546.GD1053@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/30, Russell King <rmk+lkml@arm.linux.org.uk>:
>
> If other CPUs use this then fine, but I find that having config options
> needlessly available to all architectures is annoying - especially when
> they are never used.
>
> Eg, would you ever expect to see a DM9000 ethernet device on an x86
> machine?  Probably not - there's far better PCI solutions now.
>
> So until someone says "I want to use this on such and such arch" I
> think it's better to keep it dependent on those we know are likely
> to support it.
>

That makes sens, specially if it's going to be used only by few arch.
I'll resend a new patch.

Thanks
--
               Franck
