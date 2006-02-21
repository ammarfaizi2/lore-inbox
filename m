Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161452AbWBUKKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161452AbWBUKKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWBUKKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:10:11 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:32967 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932727AbWBUKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:10:09 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 21 Feb 2006 11:08:38 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: nix@esperi.org.uk, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, davidsen@tmr.com, chris@gnome-de.org,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43FAE6A6.nailD1261QRW3@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <200602192053.25767.dhazelton@enter.net>
 <43F9F11E.nail5BM21M01Q@burner>
 <200602201340.30484.dhazelton@enter.net>
In-Reply-To: <200602201340.30484.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> > SG_IO was used in ide-scsi a long time before it was needlessly introduced
> > on top of /dev/hd*
>
> Needlessly? Not true. It was missing from the layer, as all modern ATA devices 
> do support some form of ATAPI, which is, as you've so frequently pointed out, 
> a form of SCSI. So why is an unneeded thing to introduce the ability to use 
> that full capacity?

There used to be generic support, so this way of support is unneeded.

The fact that people did make ide-scsi (the generic way) impossible to use
is a bug that needs to be fixed.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
