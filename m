Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTE0ECZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbTE0ECY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:02:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15366 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263084AbTE0ECY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:02:24 -0400
Date: Mon, 26 May 2003 21:15:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <1053994974.17129.32.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305262113470.12230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 May 2003, Alan Cox wrote:
> 
> I actually think thats a positive thing. It means 2.5 drivers/scsi is
> now very close to being the "native queueing driver" with some
> additional default plugins for doing scsi scanning, scsi error recovery 
> and a few other scsi bits.

Hey, that may well be the way to go, in which case the core stuff should
be renamed and moved off somewhere else. Leaving drivers/scsi with just 
the actual low-level SCSI drivers. 

			Linus

