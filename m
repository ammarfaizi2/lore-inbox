Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130646AbQKPPIK>; Thu, 16 Nov 2000 10:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbQKPPIB>; Thu, 16 Nov 2000 10:08:01 -0500
Received: from styx.suse.cz ([195.70.145.226]:59886 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130133AbQKPPHt>;
	Thu, 16 Nov 2000 10:07:49 -0500
Date: Thu, 16 Nov 2000 12:06:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dep <dennispowell@earthlink.net>
Cc: "Karnik, Rahul" <rakarnik@davidson.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: VIA IDE bug with WD drive?
Message-ID: <20001116120637.C665@suse.cz>
In-Reply-To: <1DE3DA661DC2D31190030090273D1E6A0153FA97@pobox.davidson.edu> <00111519564300.04831@depoffice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00111519564300.04831@depoffice.localdomain>; from dennispowell@earthlink.net on Wed, Nov 15, 2000 at 07:56:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 07:56:43PM -0500, dep wrote:
> On Wednesday 15 November 2000 19:30, Karnik, Rahul wrote:
> 
> | I get the following error if I try to enable DMA on my Abit KT7
> | motherboard with a VIA2C686 chipset:
> |
> | hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest
> | } hdb: timeout waiting for DMA
> | hda: DMA disabled
> | hdb: DMA disabled
> | ide0: reset: success
> 
> i get the same thing, along with a crc error, over and over on a 
> 20-gig WD IDE drive. alternately puzzling and frightening. 
> apparently, wd uses some nonstandard goofball error checking thing 
> that just doesn't work with linux at present. it *seems* to do no 
> harm.

Ok, both of you, we can try to track this down.

1) Please try with 2.4.0-latest. 
2) Send me the complete dmesg.
3) Send me lspci -vvvxxx
4) Send me /proc/ide/via

I'll see what I can do about the driver.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
