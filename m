Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292990AbSBVUrG>; Fri, 22 Feb 2002 15:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSBVUqz>; Fri, 22 Feb 2002 15:46:55 -0500
Received: from varenorn.icemark.net ([212.40.16.200]:64150 "EHLO
	varenorn.internal.icemark.net") by vger.kernel.org with ESMTP
	id <S292990AbSBVUqo>; Fri, 22 Feb 2002 15:46:44 -0500
Date: Fri, 22 Feb 2002 21:43:31 +0100 (CET)
From: Benedikt Heinen <beh@icemark.net>
X-X-Sender: beh@berenium.icemark.ch
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Hood <jdthood@mail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
In-Reply-To: <E16eLsl-0002w4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202222133570.1183-100000@berenium.icemark.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a reason for using all this non standard stuff. Can you reproduce
> the problem if you don't load ALSA (I dont think alsa is prime candidate
> here)

*smile*
Apparently, that's where you're wrong... I tried removing some
modules, until I found the one causing the trouble:

	snd-card-intel8x0

... :(


I guess it's time to check for newer version on that... :/




On another question, is there a way to find out a hardware config -
I can't switch off all individual devices in the notebook, but if I
use the prism2 driver from linux-wlan.com, I can't get the full
performance out of it - but just something like ~20kb/s throughput
in ftp  (Win2K gets more than 500kb/s)...
Some people on the linux-wlan mailing list suggested, it might be a
hardware conflict, but they couldn't give me a better idea on HOW
to locate it...
Any clue, how I could go about that?



      Benedikt

  BEAUTY, n.  The power by which a woman charms a lover and terrifies a
    husband.
			(Ambrose Bierce, The Devil's Dictionary)

