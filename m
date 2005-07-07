Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVGGRaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVGGRaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVGGR3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:29:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33460 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261473AbVGGR0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:26:40 -0400
Date: Thu, 7 Jul 2005 19:27:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050707172707.GI24401@suse.de>
References: <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <42CD600C.2000105@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CD600C.2000105@anagramm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Clemens Koller wrote:
> Hello,
> 
> Just for the records....
> -----
> root@ecam:~$ ./headpark /dev/hda
> head not parked 4c
> -----
> 
> HDD is a desktop Maxtor Diamond MaxPlus 9 120GB
> on a Promise Ultra133 TX2 IDE Controller.
> 
> Well, sure, it's not a notebook HDD, but maybe it's possible
> to give headpark a more generic way to get the heads parked?

This _is_ the generic way, if your drive doesn't support it you are out
of luck.

> Are the commands different per HDD model / manufacturer?
> Then we might need some information to send the proper
> commands to the different types?!

Each drive may have a vendor unique way of parking the head. But for
non-laptop drives, I would highly doubt it.

> And if there is no headpark command, might it be valuable to send
> the HDD a shutdown instead?

That would be the solution.

> PS:
> I'm working on an embedded PowerPC (MPC8540) system which
> will be turned into a high-resolution portable camera in
> the future (with acceleration sensors for the right image
> orientation). Therefore it will likely be another candidate
> for a Drop'n'Park or Drop'n'Stop (tm) feature as are planning
> to put a 2.5" notebook HDD into the cam, too.

Just make sure to choose a suitable laptop drive, then.

-- 
Jens Axboe

