Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135272AbRAaCHe>; Tue, 30 Jan 2001 21:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131243AbRAaCHY>; Tue, 30 Jan 2001 21:07:24 -0500
Received: from pcow024o.blueyonder.co.uk ([195.188.53.126]:29956 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S135272AbRAaCGs>;
	Tue, 30 Jan 2001 21:06:48 -0500
Date: Wed, 31 Jan 2001 02:06:33 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple SCSI host adapters, naming of attached devices
Message-ID: <20010131020633.J388@kermit.wd21.co.uk>
In-Reply-To: <20010130224912.A388@kermit.wd21.co.uk> <200101310105.f0V15qi03324@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200101310105.f0V15qi03324@webber.adilger.net>; from adilger@turbolinux.com on Wed, Jan 31, 2001 at 01:05:51 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jan 2001 01:05:51 Andreas Dilger wrote:

> 
> If you are using ext2 filesystems, you don't care which is which, because
> you can mount by filesystem UUID or LABEL, so just ignore the device
> names.
> The same is true with LVM.

Well, I tried changing the order of driver loading in driver/scsi/hosts.c
after reading something on the web but that didn't work.

Then I tried what you (and another kind soul) suggested, i.e. mount by
label, and the machine fails to mount the / filesystem read-write on boot,
though I can do it manually. This is a Debian potato system. Well, I'm
tired and I've had too much wine and whisky so I am going to bed, but I
will attack this afresh tomorrow night...

Thanks for the advice, perhaps I'll need more tomorrow :)
 

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
