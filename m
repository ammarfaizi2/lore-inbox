Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278631AbRJXUA5>; Wed, 24 Oct 2001 16:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278632AbRJXUAr>; Wed, 24 Oct 2001 16:00:47 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:2012 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S278631AbRJXUAZ>; Wed, 24 Oct 2001 16:00:25 -0400
Date: Wed, 24 Oct 2001 20:00:49 +0000
From: Jonas Berlin <jonas@berlin.vg>
To: Shawn Walker <swalker@fs1.theiqgroup.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: status of supermount?
Message-ID: <20011024200049.A20340@niksula.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Organization: Helsinki University of Technology
X-WindowManager: fvwm 2.2 / sawfish 0.38
X-Shell: zsh 3.0 / 3.1
X-Editor: emacs 20
X-Browser: Opera 5.0
X-ProgLanguages: Java, Perl, C, asm586, awk, sed, ruby
X-Languages: Swedish, Finnish, English
X-Homepage: http://outerspace.dyndns.org/html/personal_pages/xkr47/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone know if supermount has been ported to a more recent
> kernel by anyone? The last version of supermount I could find
> was for 2.4.0

I mailed the same question to the maintainer over six months ago but didn't
get any answer. So I upgraded the patch myself to work with versions 2.4.2,
2.4.4 and 2.4.5. At some point I switched to using 2.4.4-ac9, which I am
still using without problems, but I didn't have time back then to port the
patch to that version.

I have no idea if anyone else has done anything similar. Personally I
initially found this patch as a part of the standard kernel provided by
mandrake 7.2 (most likely), but I don't know whether they have it in there
anymore. I'll check that out. Anyway, if nobody else is already doing it, I
could try my best to port it to the newer kernels available, and also to the
-ac series, and if I succeed, possibly continue porting it when new versions
arrive. I'd be happy to have supermount support back in there myself too.

As this is the first part of kernel software I have been porting anyway,
I'll happily listen to good advice and pointers to resources that could help
me figuring out what interface changes etc there has been in the 2.4 series.
I remember there being multiple changes already between 2.4.0 and 2.4.4 that
required changing some code, partially because the patch also includes some
small changes to some generic fs code (mostly locking issues).

- xkr47
