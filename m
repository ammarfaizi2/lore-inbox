Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWAIWuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWAIWuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWAIWuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:50:16 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:44690 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751603AbWAIWuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:50:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V7tiAT5jB84EUA32WL1xqp5xKHBjCIkctZiTIqnJ5mQXRyFIjZu0qb+xo8NaRuxNXw1bmW3zY/VAL8ralNf6kH2cy0GaAKNFg9vnMfBRTj5H5N+PPMWrIzbRXO9ASXbNiuLtgLu2CFWX3DFSO4EaE/DSXov/EejtQLZY6UezcrU=
Message-ID: <21d7e9970601091449w4521c2d8vb6daa40ef0ae689d@mail.gmail.com>
Date: Tue, 10 Jan 2006 09:49:03 +1100
From: Dave Airlie <airlied@gmail.com>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601091403.46304.yarick@it-territory.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091207.14939.yarick@it-territory.ru>
	 <200601091022.30758.s0348365@sms.ed.ac.uk>
	 <200601091403.46304.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Yaroslav Rastrigin <yarick@it-territory.ru> wrote:
> Hi,
> > > > money to the right people.
> > >
> > > Could or would you be so kind to provide at least moderately complete
> > > pricelist ? Whom and how much should I pay to have correct support for
> > > intel graphics chipset, 2200BG Wi-Fi, complete
> > > suspend-to-disk/suspend-to-ram and to get an overall performance boost ?
> >
> > Since these are all supported in 2.6.15, $0 would be my quote.
> I've mentioned _correct_ support. Contrary to current rather sad state of things.
> 855GM still has no support for non-VESA videomodes (1280x800 can be enabled only via VBIOS hacks, and is not always properly restored on resume)
> (and don't supported with intelfb) (which, AFAIK, has no support for dualhead)

This can be fixed with money, send me lots of it and I'd swear I'd fix
it, however I'm lacking the other thing which is time, I'm nearly sure
I've gotten enough information to start working on some basic
modesetting for some of the external parts for these chips, however
TMDS controllers for laptop screen is probably the one area which is
going to be more difficult and at that stage it usually involves
cracking open the laptop and looking inside, or doing some "looking"
at the BIOS.

The thing is Intel could do this work as well, but they probably don't
want to release source code to drive other vendors chips (the external
chips are never from Intel) as they may not have the proper NDAs in
place, however a company like Intel could also just bully the smaller
vendors into supplying them with such NDAs, and pull the finger out.

Also the fact that the OEMs just put whatever chip onto the board they
can, and fix the Win32 drivers to use them, means Intel don't know in
a lot of cases what has been stuck to the end of the i855 chipset to
drive the internal flat panel or DVI connectors.

Dave.
