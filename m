Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281596AbRKRXWf>; Sun, 18 Nov 2001 18:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280083AbRKRXWZ>; Sun, 18 Nov 2001 18:22:25 -0500
Received: from mail012.mail.bellsouth.net ([205.152.58.32]:7930 "EHLO
	imf12bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281728AbRKRXWK>; Sun, 18 Nov 2001 18:22:10 -0500
Message-ID: <3BF84297.7FB77B3B@mandrakesoft.com>
Date: Sun, 18 Nov 2001 18:21:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Faux Pas III <fauxpas@temp123.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird PCMCIA behavior
In-Reply-To: <20011118180656.A18252@temp123.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Faux Pas III wrote:
> 
> Note: this is the same laptop mentioned above in the Maestro 2E
> thread above, so the same weird-ass power behavior applies here.
> 
> When on AC power, everything is dandy with PCMCIA.  When on
> battery power, PCMCIA device detection fails, emanating a lower
> than normal pitched beep, followed by an even lower beep.
> However, if the apm module is inserted, this makes it behave
> properly, but ONLY if the apm module was compiled with 'Make
> CPU idle calls when idle'.  Yeah, I know it's ucked fup.
> 
> Some possibly relevant details:
> 
> 2.4.{14,15-pre{3,5}}
> pcmcia-cs-3.1.29

pcmcia-cs problems are reported to http://pcmcia-cs.sourceforge.net/

We encourage you to use the kernel's cardbus code instead :)
(CONFIG_PCMCIA and CONFIG_CARDBUS)

As a side note, with kernel cardbus support, you should no longer need
external utilities or external drivers.  It should Just Work(tm).

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

