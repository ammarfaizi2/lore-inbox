Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAPOVM>; Tue, 16 Jan 2001 09:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAPOVB>; Tue, 16 Jan 2001 09:21:01 -0500
Received: from felix.convergence.de ([212.84.236.131]:63754 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S129485AbRAPOUw>;
	Tue, 16 Jan 2001 09:20:52 -0500
Date: Tue, 16 Jan 2001 15:20:23 +0100
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010116152023.A32180@convergence.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010116114018.A28720@convergence.de> <Pine.LNX.4.30.0101161338270.947-100000@elte.hu> <20010116134737.A29366@convergence.de> <20010116144849.B19949@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010116144849.B19949@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Tue, Jan 16, 2001 at 02:48:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Jamie Lokier (lk@tantalophile.demon.co.uk):
> You would need to use a new open() flag: O_ANYFD.
> The requirement comes from this like this:

>   close (0);
>   close (1);
>   close (2);
>   open ("/dev/console", O_RDWR);
>   dup ();
>   dup ();

So it's not actually part of POSIX, it's just to get around fixing
legacy code? ;-)

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
