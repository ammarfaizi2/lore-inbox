Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUI3QJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUI3QJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269333AbUI3QI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:08:59 -0400
Received: from p5089DE7B.dip.t-dialin.net ([80.137.222.123]:6404 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269324AbUI3QHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:07:05 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Date: Thu, 30 Sep 2004 17:32:02 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040929214637.44e5882f.akpm@osdl.org> <200409301452.52134.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409301452.52134.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409301732.03080.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 14:52, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 30 September 2004 06:46, Andrew Morton wrote:
> > ide broke :(   Maybe Bart's bk tree?
>
> no, disk works just fine ;)  If it is my tree I will happilly fix it.
>
> Borislav, could you apply only these patches from -mm4 and retest?
>
> linus.patch
> bk-ide-dev.patch
>
> > Begin forwarded message:
> >
> > Date: Wed, 29 Sep 2004 12:43:35 +0200
> > From: Borislav Petkov <petkov@uni-muenster.de>
> > To: Andrew Morton <akpm@osdl.org>
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: 2.6.9-rc2-mm4
> >
> >
> > <snip>
> >
> > Hello,
> >  I've already posted about problems with audio extraction but it went
> > unnoticed. Here's a recount: When I attempt to read an audio cd into wavs
> > with cdda2wav, the process starts but after a while the completion meter
> > freezes and klogd says "hdc: lost interrupt" and cdda2wav hangs itself.
> > Disabling DMA doesn't help as well as the boot option "pci=routeirq" too.
> > Older kernels like 2.6.7 do not show such behavior and there audio
> > extraction runs fine. Sysinfo attached.
> >
> > Regards,
> > Boris.

Hi people,

 well, I've applied the above patches but no change - same "hdc: lost 
interrupt" message. 2.6.9-rc3 behaves the same, as expected.

Regards,
Boris.
