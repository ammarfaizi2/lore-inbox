Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157636AbQHAAeS>; Mon, 31 Jul 2000 20:34:18 -0400
Received: by vger.rutgers.edu id <S160020AbQHAAdu>; Mon, 31 Jul 2000 20:33:50 -0400
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:4695 "HELO t1.ctrl-c.liu.se") by vger.rutgers.edu with SMTP id <S160004AbQHAAcA>; Mon, 31 Jul 2000 20:32:00 -0400
Date: 1 Aug 2000 00:43:44 -0000
Message-ID: <20000801004344.22321.qmail@t1.ctrl-c.liu.se>
From: wingel@t1.ctrl-c.liu.se
To: hpa@zytor.com
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Newsgroups: linux.kernel
In-Reply-To: <8m54u3$dh0$1@cesium.transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com> <8m4uri$d9e$1@enterprise.cistron.net>
Organization: 
Sender: owner-linux-kernel@vger.rutgers.edu

In article <8m54u3$dh0$1@cesium.transmeta.com> you hpa@zytor.com wrote:
>Let's get this straight: #include <linux/*> and #include <asm/*> are
>*expected* to be the kernel headers.  This is a completely different
>issue from the fact that glibc headers shouldn't #include these
>headers like libc5 did.

And IMHO to be able to do this, one should have to provide an explicit
-I/usr/src/my-kernel/linux/include, it should not be the default.

    /Christer

-- 
"Just how much can I get away with and still go to heaven?"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
