Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbVKPSZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbVKPSZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbVKPSZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:25:42 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:59594 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030420AbVKPSZl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:25:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jtfxNYEHwKSo2WbY32oz4+qrHOXxJOz2NnSHNx+mqLhBI+2G29eiOXcyPqgpneEtAJzog50hUBqYSr266L5uPjbK6x0etu5qVFqcF/H+lewEIn8LTpORfQN8tFfays7VNKBbqZJCwGF4tKlFTpR8/kSdacyKwoIqnFORf1CqnH8=
Message-ID: <5bdc1c8b0511161025q20569fa4hd8c187503e9af1c2@mail.gmail.com>
Date: Wed, 16 Nov 2005 10:25:40 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200511161802.47244.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
	 <1132153102.2834.37.camel@laptopd505.fenrus.org>
	 <5bdc1c8b0511160709r47c1a9afk18e47a83ced2743d@mail.gmail.com>
	 <200511161802.47244.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Wednesday 16 November 2005 15:09, Mark Knecht wrote:
> > On 11/16/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Wed, 2005-11-16 at 06:50 -0800, Mark Knecht wrote:
> > > > Hi,
> > > >    I downloaded and built 2.6.15-rc1 as a test assuming Ingo will
> > > > release -rt support for this one of these days. (No rush Ingo!) It
> > > > booted on my AMD64 machine and is running fine AFAICT.
> > > >
> > > >    One thing I was expecting to see was agpgart support for the
> > > > NForce4 chipset. Is this something that's coming or am I missing where
> > > > the configuration is done?
> > > >
> > > >    I have a PCI-Express based Radeon and would like to get better
> > > > performance. I'm presuming that agpgart support is part of that
> > > > solution? (As it was on earlier architectures?)
> > >
> > > I'm pretty sure PCI-Express and AGP are mutually exclusive....
> >
> > Ah, of course! My bad... They are different buses and connectors. I
> > was really thinking more of the 'gart' part of the agpgart.
> >
> > Is there any requirement/need/value for something like a PCI-E-gart?
> > Or does this relocation requirement go out the window somehow when a
> > graphics device moves to PCI-Express?
>
> Yes, you don't need it with PCIe.
>
> --
> Cheers,
> Alistair.

Thanks Alistair.

So, should I be able to see better grapohics performance on my Radeon
PCI-E device with 2.6.15-rc1? Are there setups I should test for you
guys? (I'm not a developer.)

Thanks,
Mark
