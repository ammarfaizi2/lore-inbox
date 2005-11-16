Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVKPPJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVKPPJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVKPPJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:09:46 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:4327 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030358AbVKPPJp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:09:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X0UjNJOD5aSU8V75N/h2W2frLCfFJeCyFE24M5oBlNYiQ88Cnkn3W6UC+q9tojtcnIiuZOsKXe5qPPlG8cZNfb/88mfQtSEBlNuPnhpg9W+mYO/NIzNgGAZO/xCG96FFx6gPMY1XeLs5s1dEA6Aizi6TiSUdEPHOU6XkvEODlpI=
Message-ID: <5bdc1c8b0511160709r47c1a9afk18e47a83ced2743d@mail.gmail.com>
Date: Wed, 16 Nov 2005 07:09:44 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1132153102.2834.37.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
	 <1132153102.2834.37.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2005-11-16 at 06:50 -0800, Mark Knecht wrote:
> > Hi,
> >    I downloaded and built 2.6.15-rc1 as a test assuming Ingo will
> > release -rt support for this one of these days. (No rush Ingo!) It
> > booted on my AMD64 machine and is running fine AFAICT.
> >
> >    One thing I was expecting to see was agpgart support for the
> > NForce4 chipset. Is this something that's coming or am I missing where
> > the configuration is done?
> >
> >    I have a PCI-Express based Radeon and would like to get better
> > performance. I'm presuming that agpgart support is part of that
> > solution? (As it was on earlier architectures?)
>
> I'm pretty sure PCI-Express and AGP are mutually exclusive....

Ah, of course! My bad... They are different buses and connectors. I
was really thinking more of the 'gart' part of the agpgart.

Is there any requirement/need/value for something like a PCI-E-gart?
Or does this relocation requirement go out the window somehow when a
graphics device moves to PCI-Express?

Thanks,
Mark
