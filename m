Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262445AbRFNMwU>; Thu, 14 Jun 2001 08:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbRFNMwK>; Thu, 14 Jun 2001 08:52:10 -0400
Received: from [217.89.38.238] ([217.89.38.238]:59379 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S262445AbRFNMwG>;
	Thu, 14 Jun 2001 08:52:06 -0400
Message-ID: <3B28B345.583B9632@pcsystems.de>
Date: Thu, 14 Jun 2001 14:51:17 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <Pine.LNX.4.05.10106102029390.24376-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The manual for my C1536A says:
>
> | The C1536A does not support termination on the device itself. Normally, the
> | unit will not be placed at the end of a bus. However, if this is
> | unavoidable, we recommend the use of an additional length of cable with a
> | terminator attached. (Lack of space does not allow for a feed-through
> | connector to be used to the drive.)
>
> | Terminator: Methode Active SCSI Terminator DM1050-02-R
> |             Methode Passive SCSI Terminator DM1050-02-0
>
> So you should get a terminator (or an addtional SCSI device that does have a
> termination dipswitch/jumper, like my CD-ROM drive :-)
>
> This also explains why it works without the C1536: in that case your SCSI host
> adapter will auto-terminate the empty narrow chain.

Thank you Geert!

That was the informations I needed all the time!
So I ordered an active terminator yesterday.

Nico

