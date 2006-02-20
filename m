Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWBTSkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWBTSkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWBTSkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:40:10 -0500
Received: from smtp.enter.net ([216.193.128.24]:58895 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932409AbWBTSkI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:40:08 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 20 Feb 2006 13:40:29 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, nix@esperi.org.uk, mj@ucw.cz,
       linux-kernel@vger.kernel.org, davidsen@tmr.com, chris@gnome-de.org,
       axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <200602192053.25767.dhazelton@enter.net> <43F9F11E.nail5BM21M01Q@burner>
In-Reply-To: <43F9F11E.nail5BM21M01Q@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602201340.30484.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 11:41, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > > Part of the problem is Jörg's expecting a solution the day before
> > > yesterday.
> >
> > Well, from some comments he made in private mails he seems to think he
> > was promised (by Linus, no less) that the DMA problems in ide-scsi were
> > going to be fixed. Instead the module was deprecated and SG_IO was
> > introduced - this seems to be one of the things he's been angry about.
>
> Even you have become a victim of the trolls :-(

Never a victim. I stick my nose where I choose - in this case I stuck it in 
here because I had hoped to turn a discussion I saw descending into a 
flamewar into something productive.

> SG_IO was used in ide-scsi a long time before it was needlessly introduced
> on top of /dev/hd*

Needlessly? Not true. It was missing from the layer, as all modern ATA devices 
do support some form of ATAPI, which is, as you've so frequently pointed out, 
a form of SCSI. So why is an unneeded thing to introduce the ability to use 
that full capacity?

And here I must parrot Martin Mares - you complain about problems when not 
using ide-scsi but almost all the bugs you've mentioned only occur when using 
ide-scsi. Now, I'll go and finish replying to all the other mails that have 
come into my inbox (on this thread) and not been sorted down because they 
were directly to me.

DRH
