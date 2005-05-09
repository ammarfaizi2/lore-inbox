Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVEIOpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVEIOpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVEIOpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:45:11 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:55477 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261401AbVEIOna convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:43:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PoFdw7Ss2U9HgIgXCvhWO2DPTXNgdkMQXHICGWRhPItUueUXJb5OS2phCW7UhR2SnCoWIhBq84NKCZ7dzAfH2AoAvb/Hpg/0itqYLmtFfCxG3n49vHDCoVyJsLVmrGvks9zQap4403TgR+nHQLpjz9pNABuTu9JrbsxD7uYGyZQ=
Message-ID: <58cb370e050509074352e98f6a@mail.gmail.com>
Date: Mon, 9 May 2005 16:43:29 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: Linux v2.6.12-rc4: IRQ14 nobody cared
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <427F6F00.9030305@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0505062245160.2233@ppc970.osdl.org>
	 <427F6F00.9030305@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/05, Paulo Marques <pmarques@grupopie.com> wrote:
> Linus Torvalds wrote:
> > [...]
> > Me, I'm off for a week of vacationing. Flee the country, like I usually do
> > after releases. Leave you suckers^H^H^H^H^H^H^Hgentle people to test it
> > all out.
> 
> It seems I'm one of the suckers^H^H^H^H^H^H^Hgentle people :)
> 
> 2.6.12-rc4 halts during boot with a "IRQ 14: nobody cared" message.
> 
> 2.6.12-rc3 boots (and works) fine with the same configuration.
> 
> IRQ14 in 2.6.12-rc3 is assigned to ide0. This is a Intel ICH5 controller
> with just a hard drive as primary master and a CDROM drive as primary slave.

Just a data-point - no IDE changes for your configuration between -rc3 and -rc4.

> I browsed the rc3-rc4 diff, but couldn't find anything really obvious,
> and it is a big diff to look in more detail.

Perhaps you can try first -rc3 git snapshot (still a lot of stuff):
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc3-git1.bz2

Bartlomiej
