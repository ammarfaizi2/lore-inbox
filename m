Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSKKRfD>; Mon, 11 Nov 2002 12:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265859AbSKKRfD>; Mon, 11 Nov 2002 12:35:03 -0500
Received: from ma-northadams1b-126.bur.adelphia.net ([24.52.166.126]:3200 "EHLO
	ma-northadams1b-126.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265851AbSKKRfC>; Mon, 11 Nov 2002 12:35:02 -0500
Date: Mon, 11 Nov 2002 12:42:33 -0500
From: Eric Buddington <eric@ma-northadams1b-126.bur.adelphia.net>
To: Jens Axboe <axboe@suse.de>
Cc: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 hangs while checking hda on PII laptop
Message-ID: <20021111124233.C8017@ma-northadams1b-126.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
References: <20021111104153.A8017@ma-northadams1b-126.bur.adelphia.net> <20021111161259.GB838@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021111161259.GB838@suse.de>; from axboe@suse.de on Mon, Nov 11, 2002 at 05:12:59PM +0100
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 05:12:59PM +0100, Jens Axboe wrote:
> On Mon, Nov 11 2002, Eric Buddington wrote:
> > This is 2.5.47, compiled for a PII laptop (Omnibook 4100) with
> > gcc-3.2. I fixed an earlier boot panic by disabling IDE-TCQ, but now
> > it hangs in the hda check (shown below) I waited at least 2 minutes
> > for it to unhang.
> > 
> > Below is as much of the boot messages as I could capture; I don't know
> > if the hdc error is significant (the drive had no media), but pulling
> > the CD-ROM did not prevent the hda hang in a subsequent boot.
> 
> Try disabling the acpi crap

Recompiled without ACPI, and I still get the same hang.

-Eric
