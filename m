Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSKTKWY>; Wed, 20 Nov 2002 05:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSKTKWY>; Wed, 20 Nov 2002 05:22:24 -0500
Received: from [195.20.224.249] ([195.20.224.249]:9228 "EHLO samoa.sitewaerts")
	by vger.kernel.org with ESMTP id <S264990AbSKTKWY>;
	Wed, 20 Nov 2002 05:22:24 -0500
From: Felix Seeger <seeger@sitewaerts.de>
To: Ducrot Bruno <poup@poupinou.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Date: Wed, 20 Nov 2002 11:29:19 +0100
User-Agent: KMail/1.5
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119183054.GA6771@suse.de> <20021120063740.GA707@poup.poupinou.org>
In-Reply-To: <20021120063740.GA707@poup.poupinou.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211201129.19007.seeger@sitewaerts.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a sony vaio qr10 and I use the sonypi driver.
If I boot the screen output will stop during acpi init and the notebook boots 
(but no screen output). I can use vnc but....

I think this also happens in 2.4, 2.5 isn't better in this.
I will try to build the kernel without sonypi (never done that) maybe it 
helps.

have fun
Felix

Am Wednesday 20 November 2002 07:37 schrieb Ducrot Bruno:
> On Tue, Nov 19, 2002 at 06:30:54PM +0000, Dave Jones wrote:
> > On Tue, Nov 19, 2002 at 03:27:31PM +0100, Ducrot Bruno wrote:
> >  > > The newer ACPI code also introduces problems that aren't
> >  > > present with the current 2.4.20rc code.
> >
> > Got it. This actually isn't a problem with new ACPI code, but
> > the addition of the new stack overflow check. It falls flat on
> > its face really early if that is enabled.
> >
> > The box is totally dead before console is initialised, so I
> > don't have backtraces, I'll give that a shot with a serial
> > console later. In the meantime, acpi folks should probably
> > try testing with CONFIG_DEBUG_STACKOVERFLOW=y to see if they
> > hit the same problems I'm getting.
>
> BTW, did you use the sonyip driver?  I am not sure at 100% but
> it look like that it request the same irq line than acpi...

