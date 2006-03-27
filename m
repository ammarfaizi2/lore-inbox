Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWC0GQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWC0GQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 01:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWC0GQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 01:16:05 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:27398 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1750739AbWC0GQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 01:16:03 -0500
From: James Cloos <cloos@jhcloos.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Schedule for adding pata to kernel?
In-Reply-To: <1143393969.2540.5.camel@localhost.localdomain> (Alan Cox's
	message of "Sun, 26 Mar 2006 18:26:08 +0100")
References: <1142869095.20050.32.camel@localhost.localdomain>
	<4422F10B.9080608@bootc.net> <44266499.3070809@t-online.de>
	<1143393969.2540.5.camel@localhost.localdomain>
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:060327:alan@lxorguk.ukuu.org.uk::cKqYLCeZ7AwBDUHX:00000000000000000000000000000000000003bJJ
X-Hashcash: 1:23:060327:linux-kernel@vger.kernel.org::pbPcvWPy/mkiaEoD:000000000000000000000000000000000Z8Hw
Date: Mon, 27 Mar 2006 01:15:50 -0500
Message-ID: <m3d5g8jtux.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> The final hard bit will be the PIIX/ICH driver as this is a major update
Alan> to a critical driver used by very many SATA people rather than a new
Alan> driver, so has the highest risk of breaking stuff.

Incidently, on that front, what is the magic to make it work?

I've not yet tried with 2.6.16 final, but I didn't have any luck with
earlier versions.

I have a:

,----[lspci]
| 00:1f.1 0101: 8086:244a (rev 03)
| 00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03)
`----

but never managed to determine the CONFIG that used ata_piix rather
than the old ide drivers.  Each attempt left me with a kernel which
could not mount its root....

-JimC
