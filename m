Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbREMMIL>; Sun, 13 May 2001 08:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbREMMIB>; Sun, 13 May 2001 08:08:01 -0400
Received: from thimm.dialup.fu-berlin.de ([160.45.217.207]:35076 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S261400AbREMMHt>; Sun, 13 May 2001 08:07:49 -0400
Date: Sun, 13 May 2001 13:55:55 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: Eric Olson <ejolson@unr.edu>
Cc: linux-kernel@vger.kernel.org,
        Jens Dreger <Jens.Dreger@physik.fu-berlin.de>,
        David Hansen <David.Hansen@physik.fu-berlin.de>
Subject: Re: FastTrack100+2.4.4 panic
Message-ID: <20010513135555.C9805@pua.nirvana>
In-Reply-To: <200105130635.f4D6ZWX10800@equinox.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105130635.f4D6ZWX10800@equinox.unr.edu>; from ejolson@unr.edu on Sat, May 12, 2001 at 11:35:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2001 at 11:35:32PM -0700, Eric Olson wrote:
> I am having trouble with the 2.4.4 kernel using MSI 694D Pro AR dual
> PIII processor motherboard with onboard Promise ATA100.
> 
> I have four nearly identically configured motherboards, two of which
> have the Promise ATA100 and two which do not.  There are no disks
> hooked to the Promise controller and I am not using it.  However, the
> motherboards with the Promise controller panic soon after the Promise
> detection lines
> 
> PDC20265: IDE controller on PCI bus 00 dev 60
> PDC20265: chipset revision 2
> PDC20265: not 100% native mode: will probe irqs later

The same happens on an MSI 6330 v3.0 (Turbo). I also tried 2.4.4-ac5 which
does not show this behaviour. The ac series have some patches related to
FastTrack/PDC20265, try it out.

BTW, do your MSI boards have a VIA chipset? If yes, do you get any IRQ
conflicts in your dmesg output?

Regards, Axel.
-- 
Axel.Thimm@physik.fu-berlin.de
