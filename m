Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVBKSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVBKSef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVBKSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:34:35 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:61638 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262278AbVBKSeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:34:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ygy6CwSJJJjqbcEUKDECsyJESaVclpIyTbx6MHmL1WkYczgTtByesQS+qTUJS7ZuoKSMECVnz3/P8QvehsOefj68QmNROvhOzKjl9bdoJAochLNhyzpyQI2MjCq8Fzg6LiVaodu49YCRwkOkClvudN5pHPSgs9v28isqTSqQg0A=
Message-ID: <58cb370e0502111033677d9a2d@mail.gmail.com>
Date: Fri, 11 Feb 2005 19:33:59 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA VT6410 IDE support for 2.6.11-rc3/via82cxxx
Cc: Mathias Kretschmer <posting@blx4.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4207A513.10601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41A2E581.2010305@blx4.net> <41A38128.90305@pobox.com>
	 <41A3A238.3070003@blx4.net> <4206A1F5.6050305@blx4.net>
	 <4207A268.3040804@blx4.net> <4207A513.10601@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2005 12:27:47 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Mathias Kretschmer wrote:
> > Mathias Kretschmer wrote:
> >
> >> Mathias Kretschmer wrote:
> >>
> >>> Jeff Garzik wrote:
> >>>
> >>>> Mathias Kretschmer wrote:
> >>>>
> >>>>> hi,
> >>>>>
> >>>>> I found an older version of this patch (against 2.4.22) on some
> >>>>> website. After a little bit of editing it applied cleanly to 2.4.27
> >>>>> (and now 2.4.28). It works fine for me on a ASUS P4P800-Deluxe with
> >>>>> 4x 300GB disks.
> >>>>>
> >>>>> Maybe someone finds this patch helpful. Any reason why the original
> >>>>> patch did not make it into the kernel ?
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> Why not add it to the existing via82cxxx driver, and get better
> >>>> performance and device tuning?
> >>
> >>
> >>
> >> OK, the attached patch adds support for the VIA 6410 chip to the
> >> via82cxxx driver (instead of the generic driver).
> >> I've tested it on the board mentioned above. Works fine for me.
> >>
> >> Cheers,
> >>
> >> Mathias
> >
> >
> > as above, but for 2.6.11-rc3
> 
> Bart, got this one?

I applied it (after whitespace cleanup) to ide-dev-2.6.

Thanks,
Bartlomiej
