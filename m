Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWCLLRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWCLLRW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 06:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWCLLRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 06:17:22 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:46731 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751411AbWCLLRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 06:17:21 -0500
Message-ID: <4414033F.2000205@drzeus.cx>
Date: Sun, 12 Mar 2006 12:17:19 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kay.sievers@vrfy.org, ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx>	<20060301194532.GB25907@vrfy.org>	<4406AF27.9040700@drzeus.cx>	<20060302165816.GA13127@vrfy.org>	<44082E14.5010201@drzeus.cx>	<4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org>
In-Reply-To: <20060311173847.23838981.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I assume you mean that the drivers/pnp/card.c patch of
> pnp-modalias-sysfs-export.patch needs to be removed and this patch applies
> on top of the result.
>
> But I don't want to break udev.
>   

I suppose I wasn't entirely clear there. I'd like you to do the first
part (remove the card.c part), but not apply this second patch. I just
sent that in as a means of getting the ball rolling again.

The reason I'm pushing this issue is that Red Hat decided to drop all
magical scripts that figured out what modules to load and instead only
use the modalias attribute. They consider the right way to go is to get
the PNP layer to export modalias, so that's what I'm trying to do.

Bugzilla entry for those interested:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=146405

Rgds
Pierre

