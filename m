Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbREOU6t>; Tue, 15 May 2001 16:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbREOU6j>; Tue, 15 May 2001 16:58:39 -0400
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:50110 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S261504AbREOU6b>; Tue, 15 May 2001 16:58:31 -0400
Date: Tue, 15 May 2001 21:58:28 +0100 (BST)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Device Numbers, LILO
In-Reply-To: <9drk37$51s$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105152156200.4099-100000@redwood.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's in, but for some strange reason you have to ask for it explicitly
> with the "lba32" option.

Because the 32bit bios calls lilo uses in lba32 mode can cause problems
with broken or old bios's hence is defaults to a safe option, and if you
can't boot without it (over 1023 cylinders) then you turn it on at your
own risk.

I know this from the experiance of breaking lilo on my workstation :)

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     tim@night-shade.org.uk        // \\  >Don't fear the penguin<
 tim@parrswood.manchester.sch.uk  /(   )\
irc: Night-Shade on openprojects   ^^-^^

Justice is incidental to law and order.
                -- J. Edgar Hoover

