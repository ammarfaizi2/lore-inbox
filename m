Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbRGVD6c>; Sat, 21 Jul 2001 23:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267888AbRGVD6W>; Sat, 21 Jul 2001 23:58:22 -0400
Received: from die-macht.oph.RWTH-Aachen.DE ([137.226.147.190]:1097 "EHLO
	die-macht") by vger.kernel.org with ESMTP id <S267886AbRGVD6K>;
	Sat, 21 Jul 2001 23:58:10 -0400
Date: Sun, 22 Jul 2001 05:58:15 +0200 (CEST)
From: Stefan Becker <stefan@oph.rwth-aachen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c
In-Reply-To: <200107212139.XAA12131@kufel.dom>
Message-ID: <Pine.LNX.4.21.0107220556310.6416-100000@die-macht>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

Andrzej Krzysztofowicz wrote:
[...]
> AFAIR, the above (and similar) #ifdefs were intentionally removed as 
they
> break using root=... kernel parameters for apropriate drivers loaded as
> module from initrd. In these cases there are 3 solutions:
[...]

Sorry, but I thought that even if a driver is built as a module the
corresponding CONFIG_* symbol is defined. I don't see the difference to
#if defined(CONFIG_ARCH_S390) as my system is i386 and doesn't need RAID
block devices.

Sorry for the disturbance, it was my first try to improve the linux
kernel and it was wrong. ;-)

Greetings,
Stefan

