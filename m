Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbREOHOd>; Tue, 15 May 2001 03:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbREOHOY>; Tue, 15 May 2001 03:14:24 -0400
Received: from mail7.bigmailbox.com ([209.132.220.38]:34320 "EHLO
	mail7.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S262662AbREOHOI>; Tue, 15 May 2001 03:14:08 -0400
Date: Tue, 15 May 2001 00:13:58 -0700
Message-Id: <200105150713.AAA18791@mail7.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [202.72.10.12]
From: "Jacky Liu" <jq419@my-deja.com>
To: linux-kernel@vger.kernel.org
Cc: hahn@coffee.psychology.mcmaster.ca
Subject: Re: 2.4.4 kernel freeze for unknown reason
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Mark, I got your point about the dma/udma stuffs. My hdparm setting is UDMA w/ MultiSector 16..

I had recompiled my kernel and disabled the FB option but my linux box still hanged (another completely freeze) yesterday... Oh well..

I have been tracking this thread for a few days and it seem the source of this problem is related to swap space. Vincent, would you mind to send me the patch for swap space problem if Alan had sent it to you? So I can test it on my machine and report the result later.

Mark, please suggest a setting for the hdparm so I can test it on my machine. Thanks alot for your time.

Best Regards,
Jacky Liu


>Date: Thu, 10 May 2001 23:20:17 -0400 (EDT)
>From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
>To: Jacky Liu <jq419@my-deja.com>
>SUBJECT
>> You are right for the other assumption, I am running the harddisk in UDMA w/32bits mode. Are you suggesting me to turn off both functions? But if I turn them off, the performance will decrease alot.
>
>the only thing that matters is dma/udma or not.  32b mode is irrelevant
>to the actual dma/udma transfer, as is -m settings.  even -u has no
>measurable effect.
>
>> Is there any way I can get any crash information? e.g. any function I can turn on for logging or something?
>
>if your hang is as I'm imagining, there's nothing you can do, since it's
>purely hardware.  you could try compiling in magic sysrq, but I suspect 
>the hardware is hung.




------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/
