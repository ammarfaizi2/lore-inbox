Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132550AbRAaBWq>; Tue, 30 Jan 2001 20:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRAaBWg>; Tue, 30 Jan 2001 20:22:36 -0500
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:46610 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S132550AbRAaBWY>;
	Tue, 30 Jan 2001 20:22:24 -0500
Date: Wed, 31 Jan 2001 01:22:07 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple SCSI host adapters, naming of attached devices
Message-ID: <20010131012207.G388@kermit.wd21.co.uk>
In-Reply-To: <20010130224912.A388@kermit.wd21.co.uk> <200101310105.f0V15qi03324@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200101310105.f0V15qi03324@webber.adilger.net>; from adilger@turbolinux.com on Wed, Jan 31, 2001 at 01:05:51 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jan 2001 01:05:51 Andreas Dilger wrote:

> If you are using ext2 filesystems, you don't care which is which, because
> you can mount by filesystem UUID or LABEL, so just ignore the device
> names.
> The same is true with LVM.
> 
> Cheers, Andreas


Well, I do care... This machine is confusing it's root filesystem with an
external SCSI disk.

But it looks like I can change the order in driver/scsi/hosts.c, though
this is not an elegant solution :(

Trying it now....

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
