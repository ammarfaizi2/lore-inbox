Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271825AbRHUS7L>; Tue, 21 Aug 2001 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271824AbRHUS7A>; Tue, 21 Aug 2001 14:59:00 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:56727 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271825AbRHUS6w>; Tue, 21 Aug 2001 14:58:52 -0400
Date: Tue, 21 Aug 2001 14:59:08 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108211859.f7LIx8A18707@devserv.devel.redhat.com>
To: bcrl@redhat.com
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
In-Reply-To: <mailman.998417940.18388.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.998417940.18388.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [...] it needs a few improvements during 2.5: I plan to submit a
> patch that replaces much of the existing pc keyboard/mouse code with state
> machine driven code that doesn't block interrupts out for long periods of
> time, as well as fixing a few of the lockup issues the current driver has.
> 
> 		-ben

Interesting. BTW, there is a request to introduce the mouse
into the Input/HID framework in the way PS/2 keyboard is now.
It does not overlap too much with a fix to hardware access,
but it may help to remove the multitude of broken code from
userland and direct it at your super-duper-state-machine code.

 http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=50921

-- Pete
