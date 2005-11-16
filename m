Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVKPSC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVKPSC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVKPSC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:02:56 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:64402 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1030294AbVKPSC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:02:56 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
Date: Wed, 16 Nov 2005 18:02:47 +0000
User-Agent: KMail/1.9
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com> <1132153102.2834.37.camel@laptopd505.fenrus.org> <5bdc1c8b0511160709r47c1a9afk18e47a83ced2743d@mail.gmail.com>
In-Reply-To: <5bdc1c8b0511160709r47c1a9afk18e47a83ced2743d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161802.47244.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 15:09, Mark Knecht wrote:
> On 11/16/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Wed, 2005-11-16 at 06:50 -0800, Mark Knecht wrote:
> > > Hi,
> > >    I downloaded and built 2.6.15-rc1 as a test assuming Ingo will
> > > release -rt support for this one of these days. (No rush Ingo!) It
> > > booted on my AMD64 machine and is running fine AFAICT.
> > >
> > >    One thing I was expecting to see was agpgart support for the
> > > NForce4 chipset. Is this something that's coming or am I missing where
> > > the configuration is done?
> > >
> > >    I have a PCI-Express based Radeon and would like to get better
> > > performance. I'm presuming that agpgart support is part of that
> > > solution? (As it was on earlier architectures?)
> >
> > I'm pretty sure PCI-Express and AGP are mutually exclusive....
>
> Ah, of course! My bad... They are different buses and connectors. I
> was really thinking more of the 'gart' part of the agpgart.
>
> Is there any requirement/need/value for something like a PCI-E-gart?
> Or does this relocation requirement go out the window somehow when a
> graphics device moves to PCI-Express?

Yes, you don't need it with PCIe.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
