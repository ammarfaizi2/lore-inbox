Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270522AbUJUARk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270522AbUJUARk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270557AbUJUARK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:17:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:47490 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270522AbUJUANQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:13:16 -0400
Date: Wed, 20 Oct 2004 17:12:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeff Garzik <jgarzik@pobox.com>
cc: John Cherry <cherry@osdl.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
In-Reply-To: <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
 <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net>
 <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net>
 <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Oct 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> >    drivers/scsi/pcmcia: 3 warnings, 0 errors
> >    drivers/scsi: 148 warnings, 0 errors
> 
> Mostly dealt with, but I'm still messing with SATA parts.

Jeff had SATA patches - it needs to use the new iomap interfaces, and then
it's much cleaner. I tested that his patches worked for me several weeks
ago, but nor all architectures had the iomap interface, so I assume Jeff
wasn't very eager to push it out.

Anyway, Al, talk to Jeff. Jeff?

		Linus
