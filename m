Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSGHEV2>; Mon, 8 Jul 2002 00:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSGHEV1>; Mon, 8 Jul 2002 00:21:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19730 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316782AbSGHEV1> convert rfc822-to-8bit; Mon, 8 Jul 2002 00:21:27 -0400
Message-ID: <3D2913C9.3030409@evision-ventures.com>
Date: Mon, 08 Jul 2002 06:23:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Eduard Bloch <edi@gmx.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
References: <20020703155113.GA26299@zombie.inka.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Eduard Bloch napisa³:
> Why not another way round? Just make the ide-scsi driver be prefered,
> and hack ide-scsi a bit to simulate the cdrom and adv.floppy devices
> that are expected as /dev/hd* by some user's configuration?

This is the intention.

> 
> To be honest - why keep ide-[cd,floppy,tape] when they can be almost
> completely replaced with ide-scsi? I know about only few cdrom devices
> that are broken (== not ATAPI compliant) but can be used with
> workarounds in the current ide-cd driver. OTOH many users do already
> need ide-scsi to access cd recorders and similar hardware, so they would
> benefit much more from having ide-scsi as default than few users of
> broken "atapi" drives.
> 
> Other operating systems did switch to constitent (scsi-based) way of
> accessing all kinds of removable media drivers. Why does Linux have to
> keep a kludge, written years ago without having a good concept?
> 
> Gruss/Regards,
> Eduard.



