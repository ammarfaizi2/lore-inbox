Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262236AbTCRJDG>; Tue, 18 Mar 2003 04:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTCRJDG>; Tue, 18 Mar 2003 04:03:06 -0500
Received: from smtp-4.hut.fi ([130.233.228.94]:62605 "EHLO smtp-4.hut.fi")
	by vger.kernel.org with ESMTP id <S262236AbTCRJDE>;
	Tue, 18 Mar 2003 04:03:04 -0500
Date: Tue, 18 Mar 2003 11:13:59 +0200 (EET)
From: Dmitrii Tisnek <dima@cc.hut.fi>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: FB error with trident CyberBlade/i1
In-Reply-To: <200303181002.18574.roy@karlsbakk.net>
Message-ID: <Pine.OSF.4.50.0303181106090.54303-100000@kosh.hut.fi>
References: <200303181002.18574.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (smtp-4.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Roy Sigurd Karlsbakk wrote:

> hi all
>
> I get a corrupted display with my Epox set-top-box if I enable the Trident
> framebuffer device. See below for lspci -vvv, and further down for .config

I always get corrupted display with the trident framebuffer
(CyberBlade/DSTN/Ai1 pci 1023:8620, ibm thinkpad laptop),
no matter what video= option or fbset arguments are used.

I suspect the refresh rate is set wrongly, and tft's are picky
about that, although I must admit I never tested it with a crt.

it could be a consequence of Trident stealing RAM and linux not
being prepared for this too.

d.
