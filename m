Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAVCyO>; Sun, 21 Jan 2001 21:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRAVCyD>; Sun, 21 Jan 2001 21:54:03 -0500
Received: from p3EE3CA38.dip.t-dialin.net ([62.227.202.56]:54799 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129401AbRAVCxw>; Sun, 21 Jan 2001 21:53:52 -0500
Date: Mon, 22 Jan 2001 03:53:37 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Resolved: FAIL: 2.2.18 + AA-VM-global-7 + serial 5.05
Message-ID: <20010122035337.A24188@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001222154757.A1167@emma1.emma.line.org> <20010101180053.D6010@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010101180053.D6010@valinux.com>; from chip@valinux.com on Mon, Jan 01, 2001 at 18:00:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jan 2001, Chip Salzenberg wrote:

> > If I now patch serial 5.05 on top of that, the kernel itself detects
> > devices, but does nothing if it's to boot /sbin/init. ctrl-alt-del
> > and Magic SysRq are both functional and can reboot the machine.

> VA's current kernel includes VM-global and serial-5.05 (and lots of
> other stuff :-)).  The only problem we had with serial-5.05 was its
> 2.2/2.4 compatibility code getting confused because 2.2.18 has more
> of 2.4's init macros available.  Try this:

[patch to remove rs_init from tty_io.c]

I finally got around to try it, and your patch did the job. Thank you
very much.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
