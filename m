Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130680AbQKNFHm>; Tue, 14 Nov 2000 00:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130681AbQKNFHc>; Tue, 14 Nov 2000 00:07:32 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:47887 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130680AbQKNFHM>; Tue, 14 Nov 2000 00:07:12 -0500
Date: Mon, 13 Nov 2000 22:37:01 -0600
To: Stefan Sassenberg <Stefan.Sassenberg@ipk.fhg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug-report: menuconfig
Message-ID: <20001113223701.D18203@wire.cadcamlab.org>
In-Reply-To: <20001113135655.C639912@kuerbis.ipk.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001113135655.C639912@kuerbis.ipk.fhg.de>; from Stefan.Sassenberg@ipk.fhg.de on Mon, Nov 13, 2000 at 01:56:55PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note for future reference: please report configuration and build bugs
to linux-kbuild@torque.net.  Speaking for myself, I am much more likely
to notice it there, as the volume is a lot lower than l-k. (:

[Stefan Sassenberg]
> When I set CONFIG_MD_BOOT to 'y' and then set neither
> CONFIG_MD_LINEAR nor CONFIG_MD_STRIPED to 'y' then although
> CONFIG_MD_BOOT is not changeable anymore it is always set. This leads
> to an error when linking the kernel because of an unresolved symbol
> "md_device_setup" (or similar).

I cannot reproduce this.  Yes, the CONFIG_MD_BOOT option is still
selected while invisible from the menu, but after exiting menuconfig it
does not appear in the .config file.

Can you send me the buggy .config that Menuconfig generated?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
