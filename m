Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTDCUzM 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263513AbTDCUzM 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:55:12 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:44737 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263512AbTDCUzJ 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:55:09 -0500
Subject: Re: RAID 5 performance problems
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jonathan Vardy <jonathan@explainerdc.com>
Cc: linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <73300040777B0F44B8CE29C87A0782E101FA97B2@exchange.explainerdc.com>
References: <73300040777B0F44B8CE29C87A0782E101FA97B2@exchange.explainerdc.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049403984.1175.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 03 Apr 2003 23:06:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-03 at 17:45, Jonathan Vardy wrote:
> I'm having trouble with getting the right performance out of my software
> raid 5 system. I've installed Red Hat 9.0 with kernel 2.4.20 compiled
> myself to match my harware (had the same problem with the default
> kernel). When I test the raid device's speed using 'hdparm -Tt /dev/hdx'
> I get this:
> /dev/md0:
> Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28 MB/sec
> Timing buffered disk reads:  64 MB in  2.39 seconds = 26.78 MB/sec

Well, if I'm not wrong, you're testing physical, individual drives, not
the RAID5, combined, logical volume. So, your values are pretty normal.

________________________________________________________________________
Linux Registered User #287198

