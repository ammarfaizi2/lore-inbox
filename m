Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285405AbRLSRe5>; Wed, 19 Dec 2001 12:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285407AbRLSRer>; Wed, 19 Dec 2001 12:34:47 -0500
Received: from windsormachine.com ([206.48.122.28]:37898 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S285405AbRLSRef>; Wed, 19 Dec 2001 12:34:35 -0500
Date: Wed, 19 Dec 2001 12:34:30 -0500 (EST)
From: Mike Dresser <mdresser@windsormachine.com>
To: Brendan Pike <spike@superweb.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE Harddrive Performance
In-Reply-To: <01121911444703.31762@spikes>
Message-ID: <Pine.LNX.4.33.0112191227250.12067-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I dont really know, I dont think its possible to get higher then that from a
> 5400 RPM disk. Heres mine,
>
> FUJITSU 40.9GB MPG3409AT 5400 RPM
>
> /dev/hda:
> Timing buffered disk reads:  64 MB in  7.96 seconds =  8.04 MB/sec

Maxtor 60.0GB 96147U8 5400 RPM (Diamond Max 60, running in ultra/33 mode)

/dev/hdd:
 Timing buffered disk reads:  64 MB in  3.45 seconds = 18.55 MB/sec

It's been a long time since i looked at the machine, so I don't remember
the mb type, it's using the PIIX4 controller, celeron 500.  The bios
doesn't support over 32 gb, so it's set to none in the bios, and Andre's
patches help Linux pick it up and run optimized.  Stock 2.2.19/20 kernels
run at about half this speed.

mike




