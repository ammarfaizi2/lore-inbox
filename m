Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160080AbQHAAnD>; Mon, 31 Jul 2000 20:43:03 -0400
Received: by vger.rutgers.edu id <S160020AbQHAAmG>; Mon, 31 Jul 2000 20:42:06 -0400
Received: from [209.10.217.66] ([209.10.217.66]:3739 "EHLO neon-gw.transmeta.com") by vger.rutgers.edu with ESMTP id <S160140AbQHAAlq>; Mon, 31 Jul 2000 20:41:46 -0400
Message-ID: <3986213D.FBACB4D1@transmeta.com>
Date: Mon, 31 Jul 2000 18:00:45 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test1-ac22-class i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: wingel@t1.ctrl-c.liu.se
Cc: hpa@zytor.com, linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
References: <7iw6kYsXw-B@khms.westfalen.de> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com> <8m4uri$d9e$1@enterprise.cistron.net> <20000801004344.22321.qmail@t1.ctrl-c.liu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

wingel@t1.ctrl-c.liu.se wrote:
> 
> In article <8m54u3$dh0$1@cesium.transmeta.com> you hpa@zytor.com wrote:
> >Let's get this straight: #include <linux/*> and #include <asm/*> are
> >*expected* to be the kernel headers.  This is a completely different
> >issue from the fact that glibc headers shouldn't #include these
> >headers like libc5 did.
> 
> And IMHO to be able to do this, one should have to provide an explicit
> -I/usr/src/my-kernel/linux/include, it should not be the default.
> 

I disagree.  It makes life far too painful for the end user, for really no gain.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
