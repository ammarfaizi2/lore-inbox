Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272782AbRIGROD>; Fri, 7 Sep 2001 13:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272784AbRIGRNw>; Fri, 7 Sep 2001 13:13:52 -0400
Received: from ns.ithnet.com ([217.64.64.10]:28171 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272782AbRIGRNf>;
	Fri, 7 Sep 2001 13:13:35 -0400
Date: Fri, 7 Sep 2001 19:13:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Bob McElrath <mcelrath@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Cached" grows and grows and grows...
Message-Id: <20010907191349.457cad95.skraw@ithnet.com>
In-Reply-To: <20010907110836.B1013@draal.physics.wisc.edu>
In-Reply-To: <20010907110836.B1013@draal.physics.wisc.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001 11:08:36 -0500 Bob McElrath
<mcelrath@draal.physics.wisc.edu> wrote:

> This is probably closely related to the vm work going on...and you're
> probably aware of it, but...
> 
> The "Cached" field in /proc/meminfo grows and grows and grows.  (kernel
> 2.4.7, 2.4.9, 2.4.10pre4aa1)  The kernel seems to be favoring buffer
> cache for the filesystem over programs.  I recently purchased 256MB more
> memory for my machine, only to find that Linux is using 200-300MB to
> cache the filesystem.  Over time it swaps out everything to disk, and
> "Cached" grows as large as 415MB on a 512MB machine.  Every time I come
> back to my machine after not using the console for a while, it has to
> swap everything back into memory in order to be usable.  (Note this
> machine is basically unloaded except for setiathome while I'm away)

To tell you the honest truth: you are not alone in cosmos (with this problem)
;-)
To give you that explicit hint for saving money: do not buy mem, it will be
eaten up by recent kernels without any performance gain or other positive
impact whatsoever. 
Try using 2.4.4, if it doesn't succeed, forget 2.4 and use 2.2.19. That works.
Unfortunately you may have to completely reinstall your system when going back
to 2.2.

Regards,
Stephan

