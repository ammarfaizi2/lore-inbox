Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310208AbSCKQxV>; Mon, 11 Mar 2002 11:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310209AbSCKQxL>; Mon, 11 Mar 2002 11:53:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310208AbSCKQxH>; Mon, 11 Mar 2002 11:53:07 -0500
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal instructions"
To: tepperly@llnl.gov (Tom Epperly)
Date: Mon, 11 Mar 2002 17:08:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3C8CD629.5090003@llnl.gov> from "Tom Epperly" at Mar 11, 2002 08:07:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kTHS-00016E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FYI when I upgraded to the 2.4.18-1smp kernel, the failure rate went 
> from 20% to 100%. I have tried running the nightly build & regression on 
> roughly 6 different dual processors Pentium III or better machines 
> (cylcing it over and over), and they all have intermittent failures of 
> one kind or another. All these machines are made by Dell, but they 
> provide some evidence that it is not a hardware problem.

It does sound like either a bad compiler (eg gcc 3) which is unlikely but
possible or your workload triggers something important and unusual which is
buggy. Do you know which bit of the workload is the trigger - is it practical
to find out ?

Alan
