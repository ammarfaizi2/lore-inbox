Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271295AbRHTPUJ>; Mon, 20 Aug 2001 11:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271269AbRHTPT7>; Mon, 20 Aug 2001 11:19:59 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:15438 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S271295AbRHTPTt>; Mon, 20 Aug 2001 11:19:49 -0400
Date: Mon, 20 Aug 2001 18:19:42 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820181942.A1844@niksula.cs.hut.fi>
In-Reply-To: <20010820105520.A22087@oisec.net> <E15YmR3-0005mb-00@the-village.bc.nu> <20010820144602.A12334@shuttle.mothership.home.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010820144602.A12334@shuttle.mothership.home.dhs.org>; from stefan.fleiter@gmx.de on Mon, Aug 20, 2001 at 02:46:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 02:46:02PM +0200, you [Stefan Fleiter] claimed:
> Hi Alan!
>  
> I have the same problem, but my Adaptec is _not_ onboard.
> 
> sf@shuttle:~$ uname -r
> 2.4.8-ac7

Same here, with 2.2.18pre19 + Gibbs aic7xxx 6.1.7.

uname -r
2.2.18pre19

cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST118273N        Rev: 6244
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: HP       Model: C5683A           Rev: C005
  Type:   Sequential-Access                ANSI SCSI revision: 02

(I reported this to Gibbs some time ago.)

Adaptec AIC-7892 Ultra 160/m SCSI host adapter (Adaptec 29160, not onboard).
No Intel bios (AMD Duron box).


-- v --

v@iki.fi
