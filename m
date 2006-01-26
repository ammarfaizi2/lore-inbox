Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWAZVfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWAZVfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAZVfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:35:01 -0500
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:45974 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751394AbWAZVfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:35:00 -0500
Date: Thu, 26 Jan 2006 13:34:59 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
  Rationale for RLIMIT_MEMLOCK?)
In-Reply-To: <Pine.LNX.4.61.0601262204370.27891@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0601261333580.22435@shell2.speakeasy.net>
References: <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de>
 <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr> <43D7AE00.nailDFJ61L10Z@burner>
 <Pine.LNX.4.61.0601262204370.27891@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Jan Engelhardt wrote:

>
> (removing Jens and Lee, as previous posts made that quite clear)
>
> >> I'm getting a grin:
> >>
> >> 15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0 grep SG_IO
> >> (no results)
> >>
> >> Looks like it's already non-redundant :)
> >
> >everything in drivers/block/scsi_ioctl.c  is duplicate code and I am sure I
> >would find more if I take some time....
>
> In what linux kernel version have you found that file?
>

In looking at http://sosdg.org/~coywolf/lxr/, that file seems to exist
in versions 2.6.10 through 2.6.14. It's gone in versions 2.6.15 and
upward, however. No comment as to the validity of that file's contents
to the discussion at hand, however. :-)

>
> Jan Engelhardt
> --

- Vadim Lobanov
