Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130893AbRAFLFt>; Sat, 6 Jan 2001 06:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130868AbRAFLFj>; Sat, 6 Jan 2001 06:05:39 -0500
Received: from mail.zmailer.org ([194.252.70.162]:53773 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130427AbRAFLF3>;
	Sat, 6 Jan 2001 06:05:29 -0500
Date: Sat, 6 Jan 2001 13:05:17 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Stefan Traby <stefan@hello-penguin.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: modprobe ipv6 gives -1 usage count was [ramfs problem...]
Message-ID: <20010106130517.B16945@mea-ext.zmailer.org>
In-Reply-To: <20010106060846.A770@stefan.sime.com> <Pine.GSO.4.21.0101060015540.25336-100000@weyl.math.psu.edu> <20010106062448.A968@stefan.sime.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010106062448.A968@stefan.sime.com>; from stefan@hello-penguin.com on Sat, Jan 06, 2001 at 06:24:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Yes, it does same with 2.2.  Nothing new here.

  It just tells to the system that that module CAN NOT BE UNLOADED.

On Sat, Jan 06, 2001 at 06:24:48AM +0100, Stefan Traby wrote:
> > 	Sure, especially considering the fact that patch was sent to
> > Linus about a month ago (several times, actually)... ;-/
> 
> I bet that a fix for the following exists, too: :)
> 
> [0]--(06:19:49)-(root@stefan)-(~)-> lsmod |grep -i ipv6
> [1]--(06:22:33)-(root@stefan)-(~)-> modprobe ipv6
> [0]--(06:22:38)-(root@stefan)-(~)-> lsmod |grep -i ipv6
> ipv6                  117424  -1 
> [0]--(06:22:46)-(root@stefan)-(~)->
> 
> usage count: -1
> -- 
>     Stefan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
