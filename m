Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314163AbSDMAwK>; Fri, 12 Apr 2002 20:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314164AbSDMAwJ>; Fri, 12 Apr 2002 20:52:09 -0400
Received: from web9203.mail.yahoo.com ([216.136.129.26]:30818 "HELO
	web9203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314163AbSDMAwI>; Fri, 12 Apr 2002 20:52:08 -0400
Message-ID: <20020413005208.22935.qmail@web9203.mail.yahoo.com>
Date: Fri, 12 Apr 2002 17:52:08 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: 2.4 sound crashes and oopses
To: chrisp@belgacom.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Full description:
>My system seems to crash "randomly" while playing sound (pcm, actually, i use
>mpg123 to test). The system has an Avance Logic ALS007 based PnP sound card.
>The crashes happen in different ways:
>- spontaneous reboot
>- hard hang (even SysRq doesn't work anymore)
>- the message "spurious 8259A interrupt: IRQ7" followed by a hard hang
>- or an Oops message (see further), followed by a DMA timeout error message.
>After this, playing audio would always trigger this timeout error message, until
>I rebooted.  Sound was broken too.

What motherboard do you have? Also, type

   lspci -v

and post the results.If your sound card is using IRQ 7, it may be conflicting with
your parallel port.


__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
