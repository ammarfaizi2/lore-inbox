Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966570AbWKOEO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966570AbWKOEO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966571AbWKOEO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:14:27 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:18655 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966570AbWKOEO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:14:26 -0500
Message-ID: <455A941F.8020305@garzik.org>
Date: Tue, 14 Nov 2006 23:14:23 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <200611150059.kAF0xBTl009796@hera.kernel.org>	 <455A6EBF.7060200@garzik.org>	 <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>	 <455A7E21.7020701@garzik.org>	 <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <1163563491.5940.209.camel@localhost.localdomain>
In-Reply-To: <1163563491.5940.209.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> I suppose none of this affects x86 for now... For ppc, once we get our
> new MSI layer in, however, I'll have to keep them enabled by default,
> though there are fewer platforms involved and the chances at this point
> are fairly high that they all use a working chipset.

Ironically there are a shitload more MSI-capable devices out there, than 
there are MSI-capable systems.

MSI simplifies things for the chip designers, so I don't doubt they are 
chomping at the bit to start putting out MSI-only devices.

	Jeff


