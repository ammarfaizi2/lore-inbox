Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132866AbRDIWej>; Mon, 9 Apr 2001 18:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDIWeT>; Mon, 9 Apr 2001 18:34:19 -0400
Received: from www.teaparty.net ([216.235.253.180]:49670 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S132865AbRDIWeJ>;
	Mon, 9 Apr 2001 18:34:09 -0400
Date: Mon, 9 Apr 2001 23:33:29 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jim Studt <jim@federated.com>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and 2.4.3 failures
In-Reply-To: <E14mi85-0002pu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10104092331350.30837-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2001, Alan Cox wrote:

> > A typical startup with 6.1.9 proceeds like this...  (6.1.10 hangs silently
> > after emitting the scsi0 and scsi1 adapter summaries, maybe it is
> > going through the same gyrations silently.) 
> 
> Try saying N to the AIC7xxx driver and Y to AIC7XXX_OLD and see if that works.

I had similar problems w. 2.4.3 on an SMP aic7xx PII, box: new driver
never managed to mount the root partition - always panicked first. Old
driver worked fine. 

-- 
"Aren't you ashamed of yourself?"
"No, I have people to do that for me."

