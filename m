Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWJEPJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWJEPJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWJEPJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:09:12 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:12040 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751488AbWJEPJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:09:10 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge window closed: v2.6.19-rc1
Date: Thu, 5 Oct 2006 16:09:12 +0100
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, stefanr@s5r6.in-berlin.de,
       linux1394-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051609.12466.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 04:29, Linus Torvalds wrote:
> Ok, it's two weeks since v2.6.18, and as a result I've cut a -rc1 release.
>
> As usual for -rc1 with a lot of pending merges, it's a huge thing with
> tons of changes, and in fact since 2.6.18 took longer than normal due to
> me traveling (and others probably also being on vacations), it's possibly
> even larger than usual.
>
> I think we got updates to pretty much all of the active architectures,
> we've got VM changes (dirty shared page tracking, for example), we've got
> networking, drivers, you name it. Even the shortlog and the diffstats are
> too big to make the kernel mailing list, but even just the summary says
> something:

Booted fine here, but I've got a few strange messages from the firewire
subsystem that weren't present in 2.6.18. I think it marginally slows down
boot up, but I could just be imagining it.

[alistair] 16:04 [~] dmesg | grep 1394
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[dffff000-dffff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[dfffc000-dfffc7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ohci1394: fw-host0: Running dma failed because Node ID is not valid
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091023fd7]
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[000129200003d023]

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
