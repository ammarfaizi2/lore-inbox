Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbQLHCfc>; Thu, 7 Dec 2000 21:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbQLHCfW>; Thu, 7 Dec 2000 21:35:22 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:21253 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129666AbQLHCfR>; Thu, 7 Dec 2000 21:35:17 -0500
Date: Thu, 7 Dec 2000 20:04:16 -0600
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <20001207200415.O6567@cadcamlab.org>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com> <Pine.LNX.3.95.1001207205043.5530A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1001207205043.5530A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Dec 07, 2000 at 08:58:01PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Dick Johnson]
> Do:
> 
> char main[]={0xff,0xff,0xff,0xff};

Oh come on, at least pick an *interesting* invalid opcode:

  char main[]={0xf0,0x0f,0xc0,0xc8};	/* try also on NT (: */

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
