Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUBEEyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 23:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUBEEyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 23:54:55 -0500
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:31650 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S263695AbUBEEyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 23:54:49 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 04:54:44 +0000
User-Agent: KMail/1.5.4
References: <200402041820.39742.wnelsonjr@comcast.net>
In-Reply-To: <200402041820.39742.wnelsonjr@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402050454.44936.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 05 February 2004 02:20, Walt Nelson wrote:
> My mouse has been acting wired occationally, not all the time. I receive
> the following error in the syslog. This has been happening since 2.6.2-RC3.
> I am currently using 2.6.2. Are these related?
>
> Feb  4 13:56:02 gumby kernel: psmouse.c: Wheel Mouse at
> isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
>
> The following occurs when starting KDE/X.
> Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set
> 2, code 0x7a on isa0060/serio0).
> Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't
> access hardware directly.
> Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set
> 2, code 0x7a on isa0060/serio0).
> Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't
> access hardware directly.
>


  I saw the same here yesterday, using a logitech wheel mouse:

Feb  4 18:19:46 vega kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 
lost synchronization, throwing 2 bytes away.

  Before this happened the mouse in X just went nuts with random clicks in 
many windows, but after that it's been ok up to now.

  FYI the mouse is detected as: 

Feb  4 08:57:42 vega kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  4 08:57:42 vega kernel: input: PS2++ Logitech Wheel Mouse on 
isa0060/serio1

  The motherboard is an Intel 440BX2 with a PII-350 running kernel 2.6.2.

Thanks 

Claudio


