Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbULBE2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbULBE2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 23:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULBE2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 23:28:11 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:7394 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S261551AbULBE2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 23:28:06 -0500
Date: Wed, 1 Dec 2004 22:28:02 -0600
From: John Lash <jlash@speakeasy.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma errors with sata_sil and Seagate disk
Message-ID: <20041201222802.4545e663@tux>
In-Reply-To: <1101944482.30990.74.camel@localhost.localdomain>
References: <20041201115045.3ab20e03@homer.sarvega.com>
	<1101944482.30990.74.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 0.9.12cvs126 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2004 23:41:22 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2004-12-01 at 17:50, John Lash wrote:
> > I don't see any indication that Seagate has released any public firmware
> > upgrades for this drive. Anybody have a suggestion?
> 
> Don't mix seagate drives and SI311x hardware is the best suggestion.
> Even if you activate the workaround for the problem you take a
> performance hit.
> 
> Please send Jeff Garzik a patch for the the change you made of course.
> 
> 

Thanks Alan, that's pretty clear ;-) Yes, performance hit, big time, 9-10 MB/sec, load average
through the roof on a big copy. Pretty much what I was expecting though. I'll look around work and
see if there is anybody I can trade with. Odd that those two devices are so wildly incompatible.

I'll roll up a patch for the change in the morning.

--john
