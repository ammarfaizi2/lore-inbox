Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbUAPUT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265621AbUAPUT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:19:26 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:20594 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265586AbUAPUSK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:18:10 -0500
Message-ID: <40084704.6020102@wanadoo.fr>
Date: Fri, 16 Jan 2004 21:18:12 +0100
From: claude parisot <Claude.PARISOT@wanadoo.fr>
Reply-To: Claude.PARISOT@wanadoo.fr
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: DOSProfi <DOSProfi@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA problem
References: <40083A5F.4060802@wanadoo.fr> <00cc01c3dc67$87fc58b0$02bfa8c0@kuecken> <40083EAB.2070906@wanadoo.fr> <200401162203.51615.DOSProfi@web.de>
In-Reply-To: <200401162203.51615.DOSProfi@web.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DOSProfi a écrit :
> I don't know if this works, but I have found a new BIOS for that board:
> 
> http://www.asus.com.tw/support/download/item.aspx?ModelName=P4P800
> 
> In the notes are many "DMA"s inside.
> 

No, doesn't work, I already have this latest version.


Thanks
> 
> 
> On Friday 16 January 2004 20:42, claude parisot wrote:
> 
>>Andreas Unterkircher a écrit :
>>
>>>Is it possible that your ide-cable can't handle the higher dma speeds
>>>and makes errors? is it udma compatible? have you looked for a
>>>firmware update for the burner @ www.plextor.com?
>>
>>Firmware is up to date ....
>>I tried it with an other cable , UDMA 100 certified,
>>I tried all kind of things, putting the drive as master
>>but nothing has worked till yet.
>>
>>
>>Thanks for your answer
>>
>>  also zu Deutsch - sprech' ich viel besser als Englisch.
>>
>>
>>mfG
>>
>>Claude
>>
>>
>>>andreas
>>>
>>>
>>>----- Original Message -----
>>>From: "claude parisot" <Claude.PARISOT@wanadoo.fr>
>>>To: <linux-kernel@vger.kernel.org>
>>>Cc: <Claude.PARISOT@wanadoo.fr>
>>>Sent: Friday, January 16, 2004 8:24 PM
>>>Subject: DMA problem
>>>
>>>
>>>> Hello !
>>>>
>>>>Sorry to post a seconfd message on the list, I am only trying
>>>>to get an answern for this - it seems so - DMA-problem ??
>>>>
>>>>
>>>>I have some
>>>>problems with a brand new Plextor-drive, PX-W5224TA/T3B, I cannot
>>>>mount any CD or burn a CDR or CD-RW, except if I disable DMA with
>>>>following command :# hdparm -d0 /dev/hdd , a little bit annoying,
>>>>isn't it ?
>>>>
>>>>If I insert a cdrom in the drive the led doesn't go out, it flashes
>>>>as usual but it stays green.
>>>>
>>>>It seems to be a DMA-problem or a kernel-bug ???
>>>>Its only a supposition, I am a Linux-newbie, and I am looking
>>>>for an explanation and a solution ....
>>>>
>>>>By mounting a cdrom I get following error messages :
>>>>
>>>>Jan 11 20:46:00 ishwara kernel: scsi : aborting command due to timeout
>>>>
>>>>: pid 102, scsi0, channel 0, id 1, lun 0 0x28 00 00 00 00 10 00 00 01 00
>>>>
>>>>Jan 11 20:46:00 ishwara kernel: hdd: error waiting for DMA
>>>>Jan 11 20:46:00 ishwara kernel: hdd: dma timeout retry: status=0x7f {
>>>>DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index
>>>>Error } Jan 11 20:46:00 ishwara kernel: hdd: dma timeout retry:
>>>>error=0x7f Jan 11 20:46:00 ishwara kernel: hdd: DMA disabled
>>>>Jan 11 20:46:00 ishwara kernel: hdd: ATAPI reset complete
>>>>Jan 11 20:46:00 ishwara kernel: hdd: irq timeout: status=0x80 { Busy }
>>>>Jan 11 20:46:00 ishwara kernel: hdd: ATAPI reset complete
>>>>Jan 11 20:46:00 ishwara kernel: hdd: irq timeout: status=0x80 { Busy }
>>>>Jan 11 20:46:00 ishwara kernel: hdd: ATAPI reset complete
>>>>Jan 11 20:46:07 ishwara kernel: hdd: irq timeout: status=0x80 { Busy }
>>>>Jan 11 20:46:07 ishwara kernel: scsi0 channel 0 : resetting for second
>>>>half of retries. Jan 11 20:46:07 ishwara kernel: SCSI bus is being reset
>>>>for host 0 channel 0. Jan 11 20:46:07 ishwara kernel: hdd: status
>>>>timeout: status=0x80 { Busy } Jan 11 20:46:07 ishwara kernel: hdd: drive
>>>>not ready for command Jan 11 20:46:07 ishwara kernel: hdd: ATAPI reset
>>>>complete Jan 11 20:46:32 ishwara kernel: scsi : aborting command due to
>>>>timeout : pid 103, scsi0, channel 0, id 1, lun 0 0x28 00 00 00 00 10 00
>>>>rive not ready for command
>>>>
>>>>And then I have a freeze or at least a blocking of the sysem.
>>>>I have to reboot.
>>>>
>>>>Could someone give me an explanation of what is happening and a way to
>>>>solve the problem .... is this a kernel-bug ? Or an incompatibility
>>>>between the motherboard and the drive ??
>>>>
>>>>If you choose to help me, please don't be to esoteric, as I already
>>>>said, I am a newbie.
>>>>
>>>>Please, could you Cc all answers to the adress :
>>>>
>>>>Claude.PARISOT@wanadoo.fr
>>>>
>>>>My apologizes for my english ....
>>>>
>>>>
>>>>Claude
>>>>
>>>>System : Pentium 2,8C
>>>>Asus P4P800 DeLuxe
>>>>Intel I865PE
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>>>>in the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


