Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132331AbRBDUiR>; Sun, 4 Feb 2001 15:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132305AbRBDUiI>; Sun, 4 Feb 2001 15:38:08 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:15558 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132332AbRBDUh4>; Sun, 4 Feb 2001 15:37:56 -0500
Message-ID: <3A7DBD8F.71941A32@Home.net>
Date: Sun, 04 Feb 2001 15:37:35 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PS hanging in 2.4.1 - More interesting things
In-Reply-To: <E14PVka-00026u-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------95A2D9C27F521C8C3D903533"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------95A2D9C27F521C8C3D903533
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Well, i found something in my logs:

This really is weird :)

Shawn.

Alan Cox wrote:

> > Well, strangely, it stopped as it started?
> > I don't know what caused it to go loopy but then it just stopped. Im using:
> > syslogd -ver
> > syslogd 1.4-0
> >
> > klogd -v
> > klogd 1.4-0
> >
> > I thought this only affected older versions?
>
> Yep. So something else happened in this case. I don't know what but that
> would appear to be a different bug
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--------------95A2D9C27F521C8C3D903533
Content-Type: text/plain; charset=iso-8859-15;
 name="dump.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dump.log"

Feb  3 18:11:35 coredump syslogd 1.4-0: restart.
Feb  3 18:11:35 coredump syslogd: select: Bad file descriptor
Feb  3 18:12:06 coredump last message repeated 214069 times
Feb  3 18:14:48 coredump syslogd 1.4-0: restart.
Feb  3 18:14:48 coredump syslogd: select: Bad file descriptor
Feb  3 18:21:08 coredump syslogd 1.4-0: restart.
Feb  3 18:21:08 coredump syslogd: select: Bad file descriptor
Feb  3 18:21:34 coredump last message repeated 168154 times
Feb  3 18:24:08 coredump syslogd 1.4-0: restart.
Feb  3 18:24:08 coredump syslogd: select: Bad file descriptor
Feb  3 18:24:39 coredump last message repeated 231290 times
Feb  3 18:26:07 coredump syslogd 1.4-0: restart.
Feb  3 18:27:24 coredump init: Switching to runlevel: 6
Feb  3 18:27:31 coredump exiting on signal 15
Feb  3 18:34:44 coredump syslogd 1.4-0: restart.


--------------95A2D9C27F521C8C3D903533--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
