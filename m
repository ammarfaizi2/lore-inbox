Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbQKNG2X>; Tue, 14 Nov 2000 01:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130789AbQKNG2O>; Tue, 14 Nov 2000 01:28:14 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:58127 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130770AbQKNG14>; Tue, 14 Nov 2000 01:27:56 -0500
Date: Mon, 13 Nov 2000 23:57:52 -0600
To: LA Walsh <law@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE0 /dev/hda performance hit in 2217 on my HW
Message-ID: <20001113235752.I18203@wire.cadcamlab.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIEJDCJAA.law@sgi.com> <20001113233357.H18203@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001113233357.H18203@wire.cadcamlab.org>; from peter@cadcamlab.org on Mon, Nov 13, 2000 at 11:33:57PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[I wrote]
> What chipset does the Inspiron 7500 use?  (Probably Intel something.

I just booted an Inspiron 5000.  PIIX4.  So in the kernel config, read
the help on PIIX support and make sure to turn on 'use dma by default'.

...And you probably still want to at least try Andre's patch.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
