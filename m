Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136514AbRD3Rzh>; Mon, 30 Apr 2001 13:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136505AbRD3RzR>; Mon, 30 Apr 2001 13:55:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13577 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136511AbRD3RzE>; Mon, 30 Apr 2001 13:55:04 -0400
Subject: Re: 2.2.19 locks up on SMP
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Mon, 30 Apr 2001 18:55:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu> from "Ion Badulescu" at Apr 28, 2001 02:21:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uHtt-0008KA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had more problems with 2.2.19 and another SMP box, which was also 
> locking up under stress. I'm not sure if it had the same messages on the 
> console, since it's headless, but it was running the same 2.2.19 kernel as 
> the previous one and was locking up in a very similar fashion. The 
> hardware in that box is 2 P-III/750MHz, 512MB RAM, 1 IDE disk on a PIIX 
> controller, and an unused aic7xxx SCSI controller with no SCSI devices 
> attached to it.
> 
> Both boxes are rock-solid when running 2.2.18-SMP.
> 
> Any ideas? Has anybody else reported this with 2.2.19?

A couple. It looks lik the VM changes may have upset something (based on
reports saying it began at that point). Can you see if 2.2.19pre stuff is
stable ?

