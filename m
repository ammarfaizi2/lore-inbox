Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274257AbRISXTt>; Wed, 19 Sep 2001 19:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274256AbRISXTj>; Wed, 19 Sep 2001 19:19:39 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:44259 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S274260AbRISXTY>;
	Wed, 19 Sep 2001 19:19:24 -0400
Message-ID: <3BA929C7.B6B6000A@sun.com>
Date: Wed, 19 Sep 2001 16:27:03 -0700
From: Stephane Brossier <stephane.brossier@sun.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [1.] X session randomly crashes because of kernel problem.
In-Reply-To: <E15ixXt-000738-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Thanks you for your time.

Below are my answers.

Alan Cox wrote:
> 
> > [2.] I installed the standart version of Mandrake8.0,
> >      and I am working under kde2.1.1 with Xfree86 4.0.3.
> >
> >      Suddenly my X session exits. Looking at the syslog
> >      I can see the following log:
> 
> Can you duplicate the problem with a more recent kernel, and also
> preferably one without the supermount patch ?
> 

I did not try that yet since I need this machine-- and this patch
to work form home. My plan is to update both my hardware and my
kernel but I wanted to report this bug anyway.

Also I can also experience the same problem but with diffrent
traces in syslog.

Sep 18 23:50:00 129 CROND[1633]: (root) CMD (   /sbin/rmmod -as)
Sep 19 00:00:00 129 CROND[1889]: (root) CMD (   /sbin/rmmod -as)
Sep 19 00:01:00 129 CROND[1895]: (root) CMD (run-parts /etc/cron.hourly)
Sep 19 00:01:45 129 kdm[1216]: Server for display :0 terminated
unexpectedly: 1536
Sep 19 00:01:56 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
r128_do_wait_for_fifo failed!
Sep 19 00:02:13 129 last message repeated 2 times
Sep 19 00:02:15 129 modprobe: modprobe: Can't locate module binfmt-0000
Sep 19 00:02:15 129 modprobe: modprobe: Can't locate module binfmt-0000
Sep 19 00:02:15 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
r128_do_wait_for_fifo failed!

I don't know if this is another bug or the same one. The behavior
is the same-- my X server crashes suddenly and the kernel seems to
be in a bad state because sometimes after that the machine reboots.

> Also does the machine past memtest86 ?

I tried that this afternoon and everything seems to be fine on
this side.

Steph.
