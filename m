Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVKPSuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVKPSuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVKPSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:50:00 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:41894 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1030410AbVKPSt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:49:59 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
Date: Wed, 16 Nov 2005 18:49:51 +0000
User-Agent: KMail/1.9
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com> <200511161802.47244.s0348365@sms.ed.ac.uk> <5bdc1c8b0511161025q20569fa4hd8c187503e9af1c2@mail.gmail.com>
In-Reply-To: <5bdc1c8b0511161025q20569fa4hd8c187503e9af1c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161849.51319.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 18:25, Mark Knecht wrote:
> On 11/16/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Wednesday 16 November 2005 15:09, Mark Knecht wrote:
[snip]
> > >
> > > Is there any requirement/need/value for something like a PCI-E-gart?
> > > Or does this relocation requirement go out the window somehow when a
> > > graphics device moves to PCI-Express?
> >
> > Yes, you don't need it with PCIe.
> >
> > --
> > Cheers,
> > Alistair.
>
> Thanks Alistair.
>
> So, should I be able to see better grapohics performance on my Radeon
> PCI-E device with 2.6.15-rc1? Are there setups I should test for you
> guys? (I'm not a developer.)

I think the latest drm tree (which might be part of -rc1, I haven't checked 
the changelogs) includes support for several PCIe radeons. Your best bet 
would probably be to compile in DRM (kernel side), check dmesg that it's 
detected your card, then download the latest snapshot of X11R6 6.9/7.0 and 
build it.

The alternative is ATI's proprietary driver which probably already supports 
your card.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
