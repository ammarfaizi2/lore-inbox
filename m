Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUBWJc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUBWJc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:32:57 -0500
Received: from post.tau.ac.il ([132.66.16.11]:33959 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S261896AbUBWJcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:32:55 -0500
Date: Mon, 23 Feb 2004 11:32:06 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: distinguish two identical network cards
Message-ID: <20040223093206.GB26628@pc-math-vis1>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <OF3A73498C.45F49506-ONC1256E43.002FC840@fiducia.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3A73498C.45F49506-ONC1256E43.002FC840@fiducia.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.4; VDF: 6.24.0.14; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 09:49:35AM +0100, andreas.hartmann@fiducia.de wrote:
> Hello!
> 
> I've got a little problem with XSeries machines, containing two identical
> builtin Broadcom NIC's. Is there any chance to get some information, which one
> of the two cards is the upper, and which one is the lower card?
> I need this information, because I want to install a lot of these machines
> automatically.
> 

Two things I can think about.

First thing is that you can look at the link lights on the card and try
doing a ping and see which one blinks.

Second, if the machines are the same they should scan the bus in the
same direction and IIRC linux numbers the cards in the order of
detection, especially if they are the same (use the same driver) and
thus it should be consistent with the numbering order of the cards
(they will always get the same number on consecutive boots).

> 
> Thank you for every hint,
> kind regards,
> Andreas Hartmann
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
