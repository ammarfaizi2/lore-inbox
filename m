Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUGLVo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUGLVo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUGLVo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:44:58 -0400
Received: from lerdorf.com ([66.198.51.121]:40413 "EHLO colo.lerdorf.com")
	by vger.kernel.org with ESMTP id S263736AbUGLVo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:44:57 -0400
Date: Mon, 12 Jul 2004 14:45:04 -0700 (PDT)
From: Rasmus Lerdorf <rasmus@lerdorf.com>
X-X-Sender: rasmus@t42p
To: Dax Kelson <dax@gurulabs.com>
cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: pcmcia on the T42p
In-Reply-To: <1089668369.3848.25.camel@mentorng.gurulabs.com>
Message-ID: <Pine.LNX.4.58.0407121442460.2147@t42p>
References: <Pine.LNX.4.58.0407102320180.1145@t42p>
 <1089668369.3848.25.camel@mentorng.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Dax Kelson wrote:
> Resetting my BIOS back to defaults and now PCMCIA hotplug is working.
>
> It seems that it *should* work with interrupts not all clumped up on
> IRQ 11 (and indeed, Windows does work with that config), but for now
> at least, my PCMCIA slots are working.

I don't actually get any beeps either, but mine works.  One of the first
things I did when I got this laptop was to "fix" those irqs.  I have mine
set to:

    A INT - 10
    B INT - 5
    C INT - 9
    D INT - 4
    E INT - 11
    F INT - 6
    G INT - 4
    H INT - 11

-Rasmus

