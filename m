Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbRFLUUe>; Tue, 12 Jun 2001 16:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbRFLUUO>; Tue, 12 Jun 2001 16:20:14 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:65399 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S263212AbRFLUUE>;
	Tue, 12 Jun 2001 16:20:04 -0400
Message-ID: <20010612221948.B19449@win.tue.nl>
Date: Tue, 12 Jun 2001 22:19:48 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Sergey Tursanov <__gsr@mail.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PC keyboard rate/delay
In-Reply-To: <E159qcp-0001XE-00@the-village.bc.nu> <53176576.20010612212337@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <53176576.20010612212337@mail.ru>; from Sergey Tursanov on Tue, Jun 12, 2001 at 09:23:37PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 09:23:37PM +0400, Sergey Tursanov wrote:
> AC> You must have been reading my mind. Yesterday I traced at least one X11
> AC> hang down to the kernel and X server both frobbing with the port at the same
> AC> time and crashing the microcontroller on my PC110.
> 
> I think it would be better to place all of kbd controller code
> into the kernel instead of using various userspace programs
> such as kbdrate. Otherwise why KDKBDREP was defined ?-)

KDKBDREP on m68k
KIOCSRATE on sparc
/dev/port on i386 etc.

Yes, we want to get rid of /dev/port.

