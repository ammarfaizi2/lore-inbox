Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSC2S2Z>; Fri, 29 Mar 2002 13:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSC2S2R>; Fri, 29 Mar 2002 13:28:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65291 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310435AbSC2S2F>; Fri, 29 Mar 2002 13:28:05 -0500
Subject: Re: Request for 2.4.20 to be a non-trivial-bugfixes-only version
To: mtopper@xarch.tu-graz.ac.at
Date: Fri, 29 Mar 2002 18:42:17 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Ruth.Ivimey-Cook@ivimey.org (Ruth Ivimey-Cook),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.LNX.4.21.0203291914160.9946-100000@xarch.tu-graz.ac.at> from "mtopper@xarch.tu-graz.ac.at" at Mar 29, 2002 07:15:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16r1KL-0001kI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > point where on the hole the painting and bolt tightening is all that needs
> > doing. The 2.4 tree suffered serious earthquake damage in 2.4.10 which
> > hasn't entirely been fixed yet.
> 
> Okay...ah...in this case: What, precisely, *is* the problem since 2.4.10 ?

Linus changed the VM and chunks of the block layer in 2.4.10, that set back
stability work very seriously. It was a mistake but it happened, and most
of the repair work is done now. Not all of it. We've also gained things like
file system direct I/O as a result, so long term it may pay off, even
though it should have gone into 2.5 for stabilizing first
