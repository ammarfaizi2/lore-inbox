Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbRFLULe>; Tue, 12 Jun 2001 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbRFLULO>; Tue, 12 Jun 2001 16:11:14 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:60233 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S263175AbRFLULG>;
	Tue, 12 Jun 2001 16:11:06 -0400
Message-ID: <20010612221050.A19449@win.tue.nl>
Date: Tue, 12 Jun 2001 22:10:50 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Sergey Tursanov <__gsr@mail.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PC keyboard rate/delay
In-Reply-To: <19562259.20010612181949@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <19562259.20010612181949@mail.ru>; from Sergey Tursanov on Tue, Jun 12, 2001 at 06:19:49PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 06:19:49PM +0400, Sergey Tursanov wrote:

> In file include/linux/kd.h was declared KDKBDREP ioctl number
> But in 2.4.x kernel there is only m68k version for that.
> I wrote some code for implement this feature on x86 machines.

Yes, it is unfortunate that many ioctls are needlessly different
between various architectures. But the utility kbdrate
works on all architectures I have tried it on.

Andries
