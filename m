Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129538AbQK3Jvm>; Thu, 30 Nov 2000 04:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132057AbQK3Jvd>; Thu, 30 Nov 2000 04:51:33 -0500
Received: from styx.suse.cz ([195.70.145.226]:22011 "EHLO kerberos.suse.cz")
        by vger.kernel.org with ESMTP id <S129538AbQK3JvS>;
        Thu, 30 Nov 2000 04:51:18 -0500
Date: Thu, 30 Nov 2000 10:18:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "S.Salman Ahmed" <ssahmed@pathcom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATA100/UDMA100 Support on the ASUS-CUSL2 mobo
Message-ID: <20001130101832.A344@suse.cz>
In-Reply-To: <14885.64113.780609.704554@phoenix.somewhere.out.there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14885.64113.780609.704554@phoenix.somewhere.out.there>; from ssahmed@pathcom.com on Thu, Nov 30, 2000 at 01:57:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 01:57:54AM -0500, S.Salman Ahmed wrote:
> 
> [I am not subscribed to the list, so please CC: me]
> 
> Hi,
> 
> How well is the ATA100/UDMA100 supported in the development kernels ? I
> have a system with an ASUS CUSL2 mobo, which has built-in ATA100 IDE
> channels, alongwith a Maxtor 20Gb ATA100 HD.
> 
> I looked at the kernel config for 2.4.0-test11, but in the "IDE, ATA and
> ATAPI Block devices" section couldn't find chipset-specific support for
> either the:
> 
> (1) Intel i815 chipset, which is what the ASUS-CUSL2 has
> 
> or the
> 
> (2) Intel I/O Controller Hub 2 (ICH2)
> 
> I'd like to get my system working using the built-in ATA100 controller
> on the ASUS CUSL2, but what options do I need in 2.4.0-test11's kernel
> config ?
> 
> Is there support for the Intel i815 chipset ?

Yes, the PIIX driver should be able to handle ICH2 and ATA100.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
