Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTDCVCt 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263631AbTDCVCt 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:02:49 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:59450 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S263629AbTDCVCq 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 16:02:46 -0500
Message-ID: <005801c2fa25$f97d0810$2e77c23e@pentium4>
From: "Jonathan Vardy" <jonathanv@explainerdc.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       "Jonathan Vardy" <jonathan@explainerdc.com>
Cc: <linux-raid@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
References: <73300040777B0F44B8CE29C87A0782E101FA97B2@exchange.explainerdc.com> <1049403984.1175.2.camel@teapot.felipe-alfaro.com>
Subject: Re: RAID 5 performance problems
Date: Thu, 3 Apr 2003 23:14:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2003-04-03 at 17:45, Jonathan Vardy wrote:
> > I'm having trouble with getting the right performance out of my software
> > raid 5 system. I've installed Red Hat 9.0 with kernel 2.4.20 compiled
> > myself to match my harware (had the same problem with the default
> > kernel). When I test the raid device's speed using 'hdparm -Tt /dev/hdx'
> > I get this:
> > /dev/md0:
> > Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28 MB/sec
> > Timing buffered disk reads:  64 MB in  2.39 seconds = 26.78 MB/sec
>
> Well, if I'm not wrong, you're testing physical, individual drives, not
> the RAID5, combined, logical volume. So, your values are pretty normal.

/dev/md0 is the raid device and as you can see from the bonny++ results in
my original mail the, performance is not really normal.

