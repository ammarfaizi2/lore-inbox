Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268373AbRGXRLm>; Tue, 24 Jul 2001 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268369AbRGXRLc>; Tue, 24 Jul 2001 13:11:32 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:46342 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S268368AbRGXRLT>; Tue, 24 Jul 2001 13:11:19 -0400
Date: Tue, 24 Jul 2001 19:11:11 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <mayfield+usenet@sackheads.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Interesting disk throughput performance problem
Message-ID: <Pine.LNX.4.30.0107241856300.7620-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Did you monitor network traffic for lost packets?

Just another wild guess: Considering the weakness of the VIA chipset,
maybe the NIC cannot do enough DMA during UDMA5 transfers.

Tim

> Hi. I'm running into some disk throughput issues that I can't explain.
> Hopefully someone reading this can offer an explanation.
>
> One of my machines is running 2.4.5 and has 2 hard drives: a 7200 rpm
> ATA100 Maxtor
> and a 5400 rpm ATA33 IBM. Each drive is a master on its own
> controller (AMI CMD649 as found on the IWill KT266-R). Both drives
> contain reiserfs 3.6x filesystems.
>
> By all local benchmarks, the 7200 rpm drive is the faster drive. But
> this doesn't seem to be the case for large files originating from remote
> clients.


