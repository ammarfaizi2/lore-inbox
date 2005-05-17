Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVEQNQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVEQNQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVEQNQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:16:46 -0400
Received: from mail.tmr.com ([64.65.253.246]:6415 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261498AbVEQNQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:16:38 -0400
Date: Tue, 17 May 2005 09:15:52 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-Reply-To: <1116255270.21358.43.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050517090828.5118A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Alan Cox wrote:

> > flashes its cache to NVRAM, or uses rotational energy to save its cache
> > on the platters, please name brand and model and where I can download
> > the material that documents this behavior.
> 
> I am not aware of any IDE drive with these properties.

I'm not sure I know of a SCSI drive which does that, either. It was a big
thing a few decades to use rotational energy to park the heads, but I
haven't seen discussion of save to nvram. Then again, I haven't been
looking for it.

What would be ideal is some cache which didn't depend on power to maintain
state, like core (remember core?) or the bubble memory which spent almost
a decade being just slightly too {slow,costly} to replace disk. There
doesn't seem to be a cost effective technology yet.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

