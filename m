Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTEGP4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTEGP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:56:47 -0400
Received: from roc-24-169-2-225.rochester.rr.com ([24.169.2.225]:23693 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP id S264088AbTEGPzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:55:17 -0400
Date: Wed, 7 May 2003 12:07:02 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Steve Spencer <spamme@analogue.hn.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan Tiger MP + 2.4.20
In-Reply-To: <S263086AbTEGLmI/20030507114208Z+5636@vger.kernel.org>
Message-ID: <Pine.LNX.4.55.0305071201130.709@death>
References: <S263086AbTEGLmI/20030507114208Z+5636@vger.kernel.org>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Steve Spencer wrote:

> Hey folks,
>
> Has anyone else experienced stability issues with 2.4.20 and Tyan Tiger
> MP mobo/Athlon MP processors?
> I think it may be a power management issue since reboot doesn't work
> properly; the machine screens go into power save mode but the box doesnt
> come back up ...
>
> Any thoughts?

I have a 2460 wtih dual 1800 MPs. When I first got it, I had all kinds of
weird stability issues (random hangs, spontaneous reboots, etc) which
turned out to be a power supply that just wasn't beefy enough. Each of
the processors can eat up to 66 watts, so by the time you throw in drives,
AGP cards, etc, you're drawing a lot of power. I upgraded to a top quality
550 watt power supply and the stability issues cleared up.

As for hanging after rebooting, it appears to be related to ACPI in 2.4
not being complete, as 2.5 works as expected.

-- 
       Ken Witherow <phantoml AT rochester.rr.com>
           ICQ: 21840670  AIM: phantomlordken
               http://www.krwtech.com/ken

