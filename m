Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQLNAZH>; Wed, 13 Dec 2000 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbQLNAY4>; Wed, 13 Dec 2000 19:24:56 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45838 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129568AbQLNAYq>; Wed, 13 Dec 2000 19:24:46 -0500
Date: Wed, 13 Dec 2000 19:59:51 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Joseph Cheek <joseph@cheek.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: test12 + initrd = swapper at 99.8% CPU time
In-Reply-To: <3A38019E.925D809B@cheek.com>
Message-ID: <Pine.LNX.4.21.0012131957470.25944-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Joseph Cheek wrote:

> hi all,
> 
> i'm using test12 to perform a clean linux install.  as soon as i get to
> a command prompt, ps axufw shows swapper at 99.8% CPU usage.  this
> didn't repro with test11, and doesn't repro if i don't use an initrd.
> 
> my load avg stays above 1 even if nothing [a couple gettys and a shell]
> is running.
> 
> what can i do to debug this?  any ideas?

Boot with "profile=2" kernel option and read readprofile (1) man page to
know how to use it. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
