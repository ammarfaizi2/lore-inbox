Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281267AbRKZAVi>; Sun, 25 Nov 2001 19:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281268AbRKZAV0>; Sun, 25 Nov 2001 19:21:26 -0500
Received: from gordon.ukservers.net ([217.10.138.217]:45319 "HELO
	gordon.ukservers.net") by vger.kernel.org with SMTP
	id <S281267AbRKZAVS>; Sun, 25 Nov 2001 19:21:18 -0500
Date: Mon, 26 Nov 2001 00:22:57 +0000
From: Mark Hymers <markh@linuxfromscratch.org>
To: linux-kernel@vger.kernel.org
Subject: Re: How do I add a drive to the DMA blacklist?
Message-ID: <20011126002257.A507@markcomp.blaydon.hymers.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200111252317.fAPNH8c10292@jik.kamens.brookline.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111252317.fAPNH8c10292@jik.kamens.brookline.ma.us>; from jik@kamens.brookline.ma.us on Sun, Nov 25, 2001 at 06:17:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25, Nov, 2001 at 06:17:08PM -0500, Jonathan Kamens spoke thus..
> How do I get a drive added to the DMA blacklists in ide-dma.c?  I sent
> E-mail to Andre Hedrick in August about a drive that claims to support
> DMA but flakes out as soon as the kernel tries to use it -- the "WDC
> AC31000H".  This is not surprising, since all the other WDC drives of
> this vintage have the same problem.  I included a patch to add this
> drive to the two blacklists in ide-dma.c.  Andre never responded to my
> E-mail, and the drive still hasn't been added to the blacklists.
> 
> Am I doing something wrong?  What do I need to do to get this drive
> added to the blacklists?
Actually, while this subject is being brought up, if I don't do:
/sbin/hdparm -d0 /dev/hdc
on bootup, my system locks up randomly.  Looks like a DMA issue with my
hdc drive.. Details are:

/proc/ide/hdc/model:
QUANTUM FIREBALLlct08 26

Are there any other details which would be handy?

Mark

-- 
Mark Hymers					 BLFS Editor
markh@linuxfromscratch.org
