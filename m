Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129217AbQJaBn7>; Mon, 30 Oct 2000 20:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbQJaBnt>; Mon, 30 Oct 2000 20:43:49 -0500
Received: from mnh-1-17.mv.com ([207.22.10.49]:49671 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129217AbQJaBnk>;
	Mon, 30 Oct 2000 20:43:40 -0500
Message-Id: <200010310251.VAA05375@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Mirko.Klemm@t-online.de (Mirko Klemm)
cc: linux-kernel@vger.kernel.org
Subject: Re: request advice: how stable is devfs in 2.4.0-test9? 
In-Reply-To: Your message of "Mon, 30 Oct 2000 22:45:48 +0100."
             <00103022454801.00908@trabant> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Oct 2000 21:51:30 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mirko.Klemm@t-online.de said:
> I am currently using 2.4.0-test* as an "ordinary user" and want to try
> some  of the 2.4 specific new features out, but this is my only system
> and I don't  want it to be messed up so much, so I'd like to hear some
> comments first.

This is one of the things that user-mode Linux (http://user-mode-linux.sourcefo
rge.net) is for.  I've been shipping kernels with devfs since devfs made it 
into the mainline pool.

With UML, you can boot up a virtual machine, and play with devfs all you want 
without any chance of messing up the host.

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
