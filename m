Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130142AbRBBVvV>; Fri, 2 Feb 2001 16:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130245AbRBBVvM>; Fri, 2 Feb 2001 16:51:12 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:51205 "EHLO devel.uklinux.net")
	by vger.kernel.org with ESMTP id <S130142AbRBBVvA>;
	Fri, 2 Feb 2001 16:51:00 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 2 Feb 2001 21:51:04 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Every Make option ends in error.
In-Reply-To: <Pine.LNX.3.95.1010202160531.692A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0102022146300.31978-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick, and Mark, thanks. It's compiling nicely now. We learn by experience.
Cheers, Ken

> Not to worry. In your new Linux directory tree do:
> 
> cd include
> mv asm /tmp	# or /usr/src, someplace temporary.
> 
> cd ..		# Back to Linux
> cp .config ..	# Save your configuration
> make mrproper	# Make like a distribution
> cp ../.config . # Restore configuration
> make oldconfig	# Re-do configuration
> make dep	# Re-do dependencies
> make bzImage	# Doit toit
> 
> After everything works, recursively delete the saved 'asm'
> directory that was moved outside the kernel tree.
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
