Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbRDAQCI>; Sun, 1 Apr 2001 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRDAQB7>; Sun, 1 Apr 2001 12:01:59 -0400
Received: from TK152095.tuwien.teleweb.at ([195.34.152.95]:52215 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S132521AbRDAQBn>;
	Sun, 1 Apr 2001 12:01:43 -0400
Date: Sun, 1 Apr 2001 18:01:25 +0200
From: Armin Obersteiner <armin@xos.net>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
   gibbs@scsiguy.com
Subject: Re: add-single-device won't work in 2.4.3
Message-ID: <20010401180125.A806@elch.elche>
In-Reply-To: <3AC5F115.B1B69883@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3AC5F115.B1B69883@torque.net>; from dougg@torque.net on Sat, Mar 31, 2001 at 10:00:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

problem resolved: the first scsi adaptor is scsi1 NOT scsi0
as in <=2.4.2. so i did add/remove devices from a non existend
controller ...

thanks for posting your /proc/scsi/scsi, i compared it with
mine from 2.4.2 and voila!

i hope this is a "wanted" behavior ...

thanks for all your fast replies!

> $ uname -a
> Linux frig 2.4.3 #1 Fri Mar 30 16:33:45 EST 2001 i586 unknown
> 
> $ cat /proc/scsi/scsi
> Attached devices: 
> Host: scsi1 Channel: 00 Id: 01 Lun: 00
>   Vendor: IBM      Model: DNES-309170W     Rev: SA30
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi2 Channel: 00 Id: 05 Lun: 00
>   Vendor: UMAX     Model: Astra 1220S      Rev: V1.2
>   Type:   Scanner                          ANSI SCSI revision: 02

CU,
	Armin Obersteiner
--
armin@xos.net                        pgp public key on request        CU
