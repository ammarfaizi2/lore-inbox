Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbWHIHMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbWHIHMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWHIHMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:12:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:62684 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030520AbWHIHM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:12:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: 2.6.18-rc3-mm2
Date: Wed, 9 Aug 2006 09:11:32 +0200
User-Agent: KMail/1.9.3
Cc: Fabio Comolli <fabio.comolli@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <b637ec0b0608081136o3adf98dbn15e206c8eea41a1c@mail.gmail.com> <200608082347.22544.dtor@insightbb.com>
In-Reply-To: <200608082347.22544.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090911.32161.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 05:47, Dmitry Torokhov wrote:
> On Tuesday 08 August 2006 14:36, Fabio Comolli wrote:
> > Hi.
> > 
> > On 8/8/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > On 8/8/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> > > > Hi Dmitry.
> > > >
> > > > On 8/8/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > > Fabio, do you have a multiplexing controller as well?
> > > >
> > > > Well, I don't even know what this means :-(
> > > > How do I know?
> > > >
> > > > However, it's a HP laptop, model name Pavillion DV4378EA.
> > > >
> > >
> > > Yep, you do have it:
> > >
> > > > i8042.c: Detected active multiplexing controller, rev 1.1.
> > >
> > > Could you please try booting with i8042.nomux and tell me if it works?
> > >
> > 
> > Yup, it works.
> > 
> 
> Fabio, Rafael,
> 
> Could you please try applying the patch below on top of -rc3-mm2 and
> see if it works without needing i8042.nomux?

Yes, it does.

Thanks,
Rafael
