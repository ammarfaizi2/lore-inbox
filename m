Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129220AbQJ3LJE>; Mon, 30 Oct 2000 06:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129244AbQJ3LIp>; Mon, 30 Oct 2000 06:08:45 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6926 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129220AbQJ3LIe>; Mon, 30 Oct 2000 06:08:34 -0500
Date: Mon, 30 Oct 2000 05:08:21 -0600
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001030050821.B9175@wire.cadcamlab.org>
In-Reply-To: <4309.972694843@ocs3.ocs-net> <20001029232347.D4EB081F9@halfway.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001029232347.D4EB081F9@halfway.linuxcare.com.au>; from rusty@linuxcare.com.au on Mon, Oct 30, 2000 at 10:23:46AM +1100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rusty]
> > CC=gcc-2723 make 2.0 kernel
> > CC=gcc-2723 make 2.2 kernel
> > CC=egcs make 2.4 kernel
> 
> No, environment doesn't override make variables by default.  This
> works on any shell:
> 
> 	make CC=egcs <targets>

If you're going to get pedantic, that won't work either -- since the
makefiles in kernels 2.0 and 2.2 expect $(CC) to include some compiler
flags.  This was fixed somewhere in 2.3.3x.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
