Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUALXNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUALXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:13:47 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:22175 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262782AbUALXNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:13:32 -0500
Message-ID: <400329AE.8050304@cyberone.com.au>
Date: Tue, 13 Jan 2004 10:11:42 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Benecke <jens-usenet@spamfreemail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1mm2: very bad interactive behaviour under XFree86
References: <2867040.OKCKYgd4AF@spamfreemail.de>
In-Reply-To: <2867040.OKCKYgd4AF@spamfreemail.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Benecke wrote:

>Hi,
>
>running an up-to-date XFree86 4.3 from Debian unstable, I have a stuck mouse
>pointer in X11 every time some application uses 100% CPU. I have
>folding@home running in the background at nice 19, which doesn't disturb
>anything, but when my machine starts up the following happens:
>
>- KDE 3.2 boots up,
>- openoffice quickstart,
>- KGpg reads a couple thousand keys,
>- xmms, xosview, background picture, etc load up
>- about 10 cm worth of applets in the KDE panel start
>
>During this time (20-30sec) the mouse pointer jerks from position to
>position about once to twice a second. My X server runs at priority 0, not
>-10, as recommended. This has been the case since 2.6.0-test11, but I have
>the (subjective) impression that under 2.6.1rc1-mm1 and 2.6.1-mm2 it got
>worse.
>

mm kernels have a small interactivity change, so it would be good to
compare with plain 2.6.1.

It is recommended that your X server run at priority 0. The -10
priority is recommended when using my interactivity patches. Its all
quite confusing.

>
>I am using an Athlon XP 2600+ with 1024MB RAM, Nforce2 chipset, NVIDIA
>XFree86 drivers.
>
>
>Shall I try vanilla 2.6.1 and compare? Or is this an obvious problem?
>

Please try 2.6.1


