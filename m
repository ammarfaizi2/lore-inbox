Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUMC7>; Tue, 21 Nov 2000 07:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQKUMCt>; Tue, 21 Nov 2000 07:02:49 -0500
Received: from styx.suse.cz ([195.70.145.226]:65007 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129208AbQKUMCf>;
	Tue, 21 Nov 2000 07:02:35 -0500
Date: Mon, 20 Nov 2000 13:47:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test11-pre6 still very broken
Message-ID: <20001120134708.A941@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <20001117223137.A26341@wirex.com> <3A162EFE.A980A941@talontech.com> <20001117235624.B26341@wirex.com> <8v6h3d$rp$1@penguin.transmeta.com> <3A191B03.6DE258C8@ife.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A191B03.6DE258C8@ife.ee.ethz.ch>; from sailer@ife.ee.ethz.ch on Mon, Nov 20, 2000 at 01:37:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 01:37:23PM +0100, Thomas Sailer wrote:

> > I hope EHCI makes it all moot. Some way or another.
> 
> Only for USB2 devices. EHCI is supposed to be paired with an existing
> UHCI or OHCI controller core that is supposed to take over the USB connector
> if an USB 1.x hub or device is plugged in. So we end up needing to support
> UHCI and OHCI for a very long time, I don't see mice and keyboards going
> USB2 anytime soon 8-)

Oops? I thought the paired controller there is for OSes not being able
to handle EHCI yet? So that USB works even for those ... I think EHCI
should handle even 1.x devices ... I may be wrong, though.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
