Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUEEJkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUEEJkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbUEEJkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:40:10 -0400
Received: from mirador.placard.fr.eu.org ([81.56.186.204]:1555 "EHLO
	mail.placard.fr.eu.org") by vger.kernel.org with ESMTP
	id S264346AbUEEJkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:40:04 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: "kernel BUG at usb-ohci.h:464!" and 8139too -- 2.4.25
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <20040504123534.GB9037@logos.cnet>
	<20040504122834.674d7e22.zaitcev@redhat.com>
From: Roland Mas <roland.mas@free.fr>
Date: Wed, 05 May 2004 11:40:02 +0200
In-Reply-To: <20040504122834.674d7e22.zaitcev@redhat.com> (Pete Zaitcev's
 message of "Tue, 4 May 2004 12:28:34 -0700")
Message-ID: <87llk7fc0d.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev, 2004-05-04 12:28:34 -0700 :

>> From: Roland Mas <roland.mas@free.fr>
>> Date:	Wed, 31 Mar 2004 22:29:32 +0200
>
>> This is my ADSL gateway/firewall.  Old ISA card (module ne), which
>> has worked flawlessly for months.  USB modem based on the Eagle
>> chipset by Analog Devices Inc. (ADI), driver is not in mainline
>> kernel, but it also has worked for months (except when my ISP
>> played silly buggers).
>
>>[...]
>>
>>   My problem: after some time (a few hours), I get a kernel panic
>> speaking of a "kernel BUG at usb-ohci.h:464!".  The only USB
>> peripheral is the ADSL modem.  If I unload 8139too and alias eth0
>> ne, but leave the Realtek NIC plugged in, I get no such panic.
>
>> | >>EIP; c4862f47 <[usb-ohci]dl_reverse_done_list+63/f0>   <=====
>
> It is not my change to usb-ohci, because that one went to 2.4.26.
> In fact, I think might actually help! Roland, please try 2.4.26.

Well, it seems to work better.  The computer has been up for more than
twelve hours now, and has supported the usual network traffic (a
handful of spa^Wemail, nntp, apt-get dist-upgrade and some web
browsing).  Let's hope it's not a fluke, and it'll stay up :-)

> Is the Eagle thing open source or binary? If it's open, it might
> stand a little review and cleanup on linux-kernel or linux-usb-devel.

  It's GPL, although it includes a GPL-but-binary firmware (used to be
sent by hotplug, but it's now in the module itself, for some reason).
I'll recommend to its authors that they come show their work to these
lists, indeed.

  Thanks,

Roland.
-- 
Roland Mas

Such compressed poems / With seventeen syllables / Can't have much meaning...
  -- in Gödel, Escher, Bach: an Eternal Golden Braid (Douglas Hofstadter)
