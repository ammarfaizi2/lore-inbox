Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbRFLQg0>; Tue, 12 Jun 2001 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbRFLQgQ>; Tue, 12 Jun 2001 12:36:16 -0400
Received: from mx5.port.ru ([194.67.23.40]:3341 "EHLO smtp5.port.ru")
	by vger.kernel.org with ESMTP id <S262651AbRFLQgB>;
	Tue, 12 Jun 2001 12:36:01 -0400
Date: Tue, 12 Jun 2001 21:23:37 +0400
From: Sergey Tursanov <__gsr@mail.ru>
X-Mailer: The Bat! (v1.49)
Reply-To: Sergey Tursanov <__gsr@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <53176576.20010612212337@mail.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re[2]: PC keyboard rate/delay
In-Reply-To: <E159qcp-0001XE-00@the-village.bc.nu>
In-Reply-To: <E159qcp-0001XE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC> You must have been reading my mind. Yesterday I traced at least one X11
AC> hang down to the kernel and X server both frobbing with the port at the same
AC> time and crashing the microcontroller on my PC110.

I think it would be better to place all of kbd controller code
into the kernel instead of using various userspace programs
such as kbdrate. Otherwise why KDKBDREP was defined ?-)

Sergey Tursanov                       mailto:__gsr@mail.ru


