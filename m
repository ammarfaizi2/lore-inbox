Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUHPUrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUHPUrW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267955AbUHPUrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:47:22 -0400
Received: from gprs214-155.eurotel.cz ([160.218.214.155]:53637 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267953AbUHPUrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:47:20 -0400
Date: Mon, 16 Aug 2004 22:47:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Jenkins <sourcejedi@phonecoop.coop>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cd burning: kernel / userspace?
Message-ID: <20040816204707.GE25783@elf.ucw.cz>
References: <41189AA2.3010908@phonecoop.coop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41189AA2.3010908@phonecoop.coop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Why can't a similar method be used for DAO writing?  Packet writing and 
> Mount Rainer support belongs in the kernel - why not normal cd burning?  
> On modern "burnproof" hardware, it should be possible to use dd to write 
> your disk image to the cdrecorder device.  I'm guessing that this just 
> isn't as interesting, especially with userspace programs available to do 
> the job.

It would certainly be nice... Character device + some ioctls should do
the trick. Someone simply needs to write implement it and see if it
ends up simple addition or ugly hack.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
