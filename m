Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRACBIr>; Tue, 2 Jan 2001 20:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRACBIh>; Tue, 2 Jan 2001 20:08:37 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:2308 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129734AbRACBI1>; Tue, 2 Jan 2001 20:08:27 -0500
Date: Wed, 3 Jan 2001 00:37:48 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Gerold Jury <geroldj@grips.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <3A522A57.3050307@grips.com>
Message-ID: <Pine.LNX.4.30.0101030027220.1221-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Jan 2001, Gerold Jury wrote (in a private message, sorry):

> The machine is single CPU no SMP.
> It hangs with or without X when i hangup the ippp0 interface.
> One of the scripts that run when the line is hung up may do a ifconfig
> ippp0 down afterwards which could be the actual reason.

Turn off CONFIG_ISDN_DIVERSION. S'broken. I think Alan has fixes if you
really need it.

-- 
dwmw2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
