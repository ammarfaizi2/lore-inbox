Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbTDCHzH>; Thu, 3 Apr 2003 02:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbTDCHzH>; Thu, 3 Apr 2003 02:55:07 -0500
Received: from denise.shiny.it ([194.20.232.1]:9944 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S263250AbTDCHzG>;
	Thu, 3 Apr 2003 02:55:06 -0500
Message-ID: <XFMail.20030403100629.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3E8B524A.1060605@canada.com>
Date: Thu, 03 Apr 2003 10:06:29 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>,
       Oliver Feiler <kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02-Apr-2003 Nehal wrote:
> ok you are right! i set hdc=scsi, reboot, and mounted my
> ide cdrom drive (device /dev/scd1) as hfs, and boom
> it crashed with same message :)  this is good, at least
> i know its not my scsi drive/controller at fault
>
> so definitely a bug in scsi somehow or somewhere,
> so i guess anyone with a hfs cd can reproduce, so
> somebody please fix :)

Once upon a time it worked just fine. Then someone removed
support for !=512 bytes sectors...
To workaround, use loopback.


Bye.

