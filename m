Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbRAaGu2>; Wed, 31 Jan 2001 01:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130359AbRAaGuR>; Wed, 31 Jan 2001 01:50:17 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:24592
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129786AbRAaGuB>; Wed, 31 Jan 2001 01:50:01 -0500
Date: Tue, 30 Jan 2001 22:49:26 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C686X
In-Reply-To: <Pine.LNX.4.21.0101301847530.3488-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.10.10101302247530.4244-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, David D.W. Downey wrote:

> 
> Woohoo! Just found out that ATA66 on the VIA aint too great.
> 
> I set the kernel boot options idebus=66 ide0=ata66 enabling ATA66

Sorry but you are not right in this world .......

Where in you manual does is "QUOTE" you can drive the ATA/IDE bus at 66MHz?


> according to dmesg. The HDD is a WDC UDMA100 30.5GB drive. I retried the
> 
> dd if=/dev/hda7 of=/tmp/testing2.img bs=1024k count=2000 
> 
> on one VT, ran renice -20 on the dd process then ran procinfo on another
> and top on a 3rd. I logged into a fourth and ran sync;sync;sync;sync;sync.
> 
> After @30 seconds the machine became totally unresponsive, locking up all
> but the current VT.
> 
> I let it sit there and waited until the dd finished in case the renice was
> what killed the control. When dd finished I tried running any type of
> command but the tty was completely frozen. All other VTs were non
> responsive as well.
> 
> 
> This is gonna be fun when I test the Promise controller. hehe
> 
> 
> David D.W. Downey
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
