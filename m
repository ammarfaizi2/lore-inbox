Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbTCTQXc>; Thu, 20 Mar 2003 11:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbTCTQXc>; Thu, 20 Mar 2003 11:23:32 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:60293 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261515AbTCTQX2>;
	Thu, 20 Mar 2003 11:23:28 -0500
Message-ID: <3E79ED9F.1000402@portrix.net>
Date: Thu, 20 Mar 2003 17:34:39 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with bttv in latest bk
References: <3E78BB99.3070605@portrix.net> <87he9z7z95.fsf@bytesex.org> <3E796530.2010707@portrix.net> <87znnqmitn.fsf@bytesex.org>
In-Reply-To: <87znnqmitn.fsf@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>------------[ cut here ]------------
>>kernel BUG at drivers/media/video/bttv-risc.c:742!
> 
> 
> Not reproducable here with latest bttv bits.  Sure you have the latest
> module loaded?  bttv prints the version number at insmod time, should be
> 0.9.6 (vanilla 2.5.65 has 0.9.4 I think) ...
> 
>   Gerd
> 
bttv: driver version 0.9.7 loaded
Would it make sense to try as module? Currently it is compiled in.

Jan

Linux video capture interface: v1.00
bttv: driver version 0.9.7 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is VIA Technologies, In VT8363/8365 [KT133/K
bttv: Host bridge is VIA Technologies, In VT82C686 [Apollo Sup
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 00:0e.0, irq: 5, latency: 32, mmio: 0xeb120000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=61324, tuner=Philips FI1216 MK2 (5), radio=no
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
msp34xx: init: chip=MSP3410D-B4 +nicam +simple
msp3410: daemon started
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
tda9887: probing bt848 #0 i2c adapter [id=0x10005]

