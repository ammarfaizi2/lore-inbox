Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264522AbRFOUhA>; Fri, 15 Jun 2001 16:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264525AbRFOUgu>; Fri, 15 Jun 2001 16:36:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2568 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264522AbRFOUgg>; Fri, 15 Jun 2001 16:36:36 -0400
Subject: Re: ps2 keyboard filter hook
To: ddstreet@us.ibm.com
Date: Fri, 15 Jun 2001 21:35:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10106151345510.25518-200000@ddstreet.raleigh.ibm.com> from "ddstreet@us.ibm.com" at Jun 15, 2001 04:03:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15B0Jc-00073n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The registered drivers are called (in order of registration) for every scancode,
> and they may change or consume the scancode (or allow it to pass).  Also the
> 'filters' are given a function to send an variable-sized buffer to the keyboard
> output port; this function is synchronized using a semaphore which also
> coordinates with pckbd_leds().

X11 likes to talk direct to the PS/2 port.  I actually think you should instead
talk to Vojtech for the mainstream kernel about the input device work. It 
sounds much cleaner and more close to what you need

