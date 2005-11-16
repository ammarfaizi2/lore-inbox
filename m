Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbVKPTys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbVKPTys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKPTys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:54:48 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:14267 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030457AbVKPTyr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:54:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ji3SXgfRJ3f4iIdJX+Aqag7gaQ6cSL29cuxfbYquK5JwhgAghIBWOOLo7Vx1q7SHLVfDUBqE5IfUFNbKZReUpU/2raVQsr/4X07KzyvFMnNTUMtIWRMsKGKiHeFY+AlMhq/0Xk2nRpkiaa3V+TuPnr80Dk3aJElr1ShIbmuA6Es=
Message-ID: <5bdc1c8b0511161154y374b131jaa6c78badc221dd0@mail.gmail.com>
Date: Wed, 16 Nov 2005 11:54:47 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200511161849.51319.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
	 <200511161802.47244.s0348365@sms.ed.ac.uk>
	 <5bdc1c8b0511161025q20569fa4hd8c187503e9af1c2@mail.gmail.com>
	 <200511161849.51319.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Wednesday 16 November 2005 18:25, Mark Knecht wrote:
> > On 11/16/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > On Wednesday 16 November 2005 15:09, Mark Knecht wrote:
> [snip]
> > > >
> > > > Is there any requirement/need/value for something like a PCI-E-gart?
> > > > Or does this relocation requirement go out the window somehow when a
> > > > graphics device moves to PCI-Express?
> > >
> > > Yes, you don't need it with PCIe.
> > >
> > > --
> > > Cheers,
> > > Alistair.
> >
> > Thanks Alistair.
> >
> > So, should I be able to see better grapohics performance on my Radeon
> > PCI-E device with 2.6.15-rc1? Are there setups I should test for you
> > guys? (I'm not a developer.)
>
> I think the latest drm tree (which might be part of -rc1, I haven't checked
> the changelogs) includes support for several PCIe radeons. Your best bet
> would probably be to compile in DRM (kernel side), check dmesg that it's
> detected your card, then download the latest snapshot of X11R6 6.9/7.0 and
> build it.
>
> The alternative is ATI's proprietary driver which probably already supports
> your card.

Thanks. I'll see if this old guitar player can get all of that done.

Cheers,
Mark
