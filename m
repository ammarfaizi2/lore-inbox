Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUKOFLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUKOFLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 00:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUKOFLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 00:11:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13324 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261443AbUKOFLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 00:11:47 -0500
Date: Mon, 15 Nov 2004 06:02:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] SCSI: misc possible cleanups
Message-ID: <20041115050232.GB2235@stusta.de>
References: <20041115020432.GK2249@stusta.de> <1100494253.24811.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100494253.24811.9.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 10:50:46PM -0600, James Bottomley wrote:
> On Sun, 2004-11-14 at 20:04, Adrian Bunk wrote:
> > This patch below does:
> > - remove unused code
> 
> Erm, some of the code you're trying to remove was recently added as
> enablers for fibre channel drivers, like this:
> 
> [...]
> 
> >  drivers/scsi/scsi_transport_fc.c  |  202 ------------------------------
> 
> It's really not safe to remove code without understanding why it's there
> in the first place.

That's exactly why I wrote:

<--  snip  -->

It is meant for review and not for being applied immediately.
It should simply demonstrate with users are possible with the current 
in-kernel users today.

<--  snip  -->

OK, the last wasn't a correct sentence.

I wanted to say:
It should simply demonstrate with changes are possible with the current 
in-kernel users.

> James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

