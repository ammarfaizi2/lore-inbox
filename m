Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbRGLAfy>; Wed, 11 Jul 2001 20:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbRGLAfp>; Wed, 11 Jul 2001 20:35:45 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:54663 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S267384AbRGLAf2>; Wed, 11 Jul 2001 20:35:28 -0400
Message-ID: <3B4CF1BB.138FB64B@kegel.com>
Date: Wed, 11 Jul 2001 17:39:23 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Improving (network) IO performance ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very cool.  Thanks for doing a no-scan implementation of /dev/poll!
Two questions:

1) have you compared its performance against Vitaly Luban's 
signal-per-fd patch?  Even though it's realtime-signal based,
there's some hope for it being quite efficient.  See
http://www.luban.org/GPL/gpl.html and
http://boudicca.tux.org/hypermail/linux-kernel/2001week20/1353.html

2) A little birdie told me that someone had gotten a freebsd
box to handle something like half a million connections.
I would like to see you extend the horizontal axis of your graph
by a couple orders of magnitude :-)

Thanks,
Dan

p.s. I have updated http://www.kegel.com/c10k.html#nb./dev/poll
with a link to your report.
