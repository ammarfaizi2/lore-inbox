Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRICOZp>; Mon, 3 Sep 2001 10:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271721AbRICOZg>; Mon, 3 Sep 2001 10:25:36 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:32266 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271719AbRICOZ2>; Mon, 3 Sep 2001 10:25:28 -0400
Message-ID: <3B9392D8.BC963F23@folkwang-hochschule.de>
Date: Mon, 03 Sep 2001 16:25:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fred <fred@arkansaswebs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-ac11 lockup when burning cds
In-Reply-To: <3B922604.A8E3EB5F@folkwang-hochschule.de> <3B9232D8.143FC76D@folkwang-hochschule.de> <01090216434100.01174@bits.linuxball>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fred wrote:
> 
> burning on 2.4.9-ac5 works fine for me with
> amd 500
> 12x ide cdrw
> 256MB ram
> ali mainboard
> 
> what's your hardware config?

#cdrecord -scanbus
Cdrecord 1.9 (i686-suse-linux) Copyright (C) 1995-2000 Jörg
Schilling
Linux sg driver version: 3.1.20
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) 'IBM     ' 'DCAS-34330W     ' 'S65A' Disk
        0,2,0     2) 'TOSHIBA ' 'CD-ROM XM-6201TA' '1037' Removable
CD-ROM
scsibus2:
        2,0,0   200) 'PHILIPS ' 'CDD3610 CD-R/RW ' '2.02' Removable
CD-ROM

there is another pci scsi adaptor (a symbios) for my scanner, but i
only load the module on demand, and it wasn't loaded when the lockup
occured.

i see you are running UP, perhaps it's a SMP related problem ?

will try playing with some debug options and linus' release...



-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
