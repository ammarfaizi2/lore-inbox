Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261247AbRERA0g>; Thu, 17 May 2001 20:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbRERA0Q>; Thu, 17 May 2001 20:26:16 -0400
Received: from radio.protv.ro ([193.230.227.51]:18191 "EHLO radio.protv.ro")
	by vger.kernel.org with ESMTP id <S261247AbRERA0N>;
	Thu, 17 May 2001 20:26:13 -0400
Message-ID: <4085.193.230.227.44.990145565.squirrel@radio.protv.ro>
Date: Fri, 18 May 2001 03:26:05 +0300 (EEST)
Subject: Re: Ide Floppy problems
From: "Mihai Moldovanu" <mihaim@profm.ro>
To: jari.ruusu@pp.inet.fi
In-Reply-To: <3B044EE7.B77BA8EA@pp.inet.fi>
In-Reply-To: <3B044EE7.B77BA8EA@pp.inet.fi>
Cc: linux-kernel@vger.kernel.org
Reply-To: mihaim@profm.ro
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> May 17 05:42:20 m kernel: hdd: lost interrupt
>> May 17 05:42:20 m kernel: ide-floppy: CoD != 0 in idefloppy_pc_intr
>> May 17 05:42:20 m kernel: hdd: ATAPI reset complete
>> May 17 05:43:10 m kernel: hdd: lost interrupt
>> May 17 05:43:10 m kernel: ide-floppy: CoD != 0 in idefloppy_pc_intr
>> May 17 05:43:10 m kernel: hdd: ATAPI reset complete
>> After another 1 minute of this repeated messages I push reset .
>> Any ideeas ?
>
> CONFIG_BLK_DEV_IDEFLOPPY=n
> CONFIG_BLK_DEV_IDESCSI=y
> CONFIG_SCSI=y
> CONFIG_BLK_DEV_SD=y
>
> And, your ZIP drive shows up as SCSI disk. This also has the advantage
> that you can use ziptool to write protect / unprotect / eject ZIP
> disks. Ide-floppy never worker properly for me. Ide-scsi has worked
> without problems.


Does not work with SCSI drivers. Same kind of error .

May 18 03:10:02 m kernel: hdd: lost interrupt
May 18 03:10:02 m kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
May 18 03:10:02 m kernel: hdd: ATAPI reset complete
May 18 03:10:02 m kernel: hdd: irq timeout: status=0x80 { Busy }

-- 
Mihai Moldovanu



