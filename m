Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284200AbRLZQtb>; Wed, 26 Dec 2001 11:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283876AbRLZQtM>; Wed, 26 Dec 2001 11:49:12 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:1755 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S284246AbRLZQtH>;
	Wed, 26 Dec 2001 11:49:07 -0500
Date: Wed, 26 Dec 2001 11:49:06 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Jelnin Andrey <bsod@gs7.saminfo.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: I have problem with SB-FMI16 radio
In-Reply-To: <200112262042.fBQKgj3F029225@ns.gs7.saminfo.ru>
Message-ID: <Pine.LNX.4.30.0112261147401.20982-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001, Jelnin Andrey wrote:

> Hi
> I have problem with SB-FMI16 radio
>
> I use plain 2.4.5 kernel from Slackware 8.0
> 1. I compile module for radio-sb16fmi  - that's ok
> 2. I /sbin/modprobe radio-sb16fmi io=0x284  - that's ok
> 3. When I try to control radio I hear nothing
> What is this ???
>
> PS In RedHat 6.2 - it work's without problem ???

This is a stupid suggestion, but try running something like aumix or
something to turn the volume on the output channels on.  For some reason,
on some soundcards, the driver somehow initializes the board to have 0%
volume on all output channels!!

It's possible that internally redhat compensates for this by doing that
"applying mixer settings" thing you see at bootup... which would explain
why it works in redhat and not in slackware...

-Calin

