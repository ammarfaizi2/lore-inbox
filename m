Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287112AbSAGVQM>; Mon, 7 Jan 2002 16:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287109AbSAGVQD>; Mon, 7 Jan 2002 16:16:03 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:10253 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S287106AbSAGVPp>; Mon, 7 Jan 2002 16:15:45 -0500
Date: Mon, 7 Jan 2002 16:15:45 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "=?iso-8859-1?Q?J=F6rn_Nettingsmeier?=" 
	<nettings@folkwang-hochschule.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 usbnet usb.c: USB device not accepting new address
Message-ID: <20020107161544.J10145@sventech.com>
In-Reply-To: <3C3A0B1A.6441FC74@folkwang-hochschule.de> <3C3A0E29.99650F60@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3A0E29.99650F60@folkwang-hochschule.de>; from nettings@folkwang-hochschule.de on Mon, Jan 07, 2002 at 10:07:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not responding to the SETUP packet. I'd check the cable, or maybe
the connector on the motherboard.

Does it enumerate in Windows?

JE

On Mon, Jan 07, 2002, Jörn Nettingsmeier <nettings@folkwang-hochschule.de> wrote:
> btw, here's the error message i get from uhci.o
> (as opposed to usb-uhci.o, which i had pasted into my earlier post)
> 
> Jan  7 22:05:18 kleineronkel kernel: usb.c: kusbd: /sbin/hotplug add
> 6
> Jan  7 22:05:18 kleineronkel kernel: usb.c: kusbd policy returned
> 0xfffffffe
> Jan  7 22:05:18 kleineronkel kernel: hub.c: port 2 connection change
> Jan  7 22:05:18 kleineronkel kernel: hub.c: port 2, portstatus 101,
> change 1, 12 Mb/s
> Jan  7 22:05:18 kleineronkel kernel: hub.c: port 2, portstatus 103,
> change 0, 12 Mb/s
> Jan  7 22:05:18 kleineronkel kernel: hub.c: USB new device connect
> on bus1/2, assigned device number 7
> Jan  7 22:05:18 kleineronkel kernel: uhci.c: uhci_result_control()
> failed with status 440000
> Jan  7 22:05:18 kleineronkel kernel: [d7d000c0] link (17d00062)
> element (1193e1e0)
> Jan  7 22:05:18 kleineronkel kernel:   0: [d193e1e0] link (1193e210)
> e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0,
> PID=2d(SETUP) (buf=1f1fd2a0)
> Jan  7 22:05:18 kleineronkel kernel:   1: [d193e210] link (00000001)
> e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN)
> (buf=00000000)
> Jan  7 22:05:18 kleineronkel kernel:
> Jan  7 22:05:18 kleineronkel kernel: usb.c: USB device not accepting
> new address=7 (error=-110)
> Jan  7 22:05:18 kleineronkel kernel: hub.c: port 2, portstatus 103,
> change 0, 12 Mb/s
> Jan  7 22:05:18 kleineronkel kernel: hub.c: USB new device connect
> on bus1/2, assigned device number 8
> Jan  7 22:05:18 kleineronkel kernel: uhci.c: uhci_result_control()
> failed with status 440000
> Jan  7 22:05:18 kleineronkel kernel: [d7d000c0] link (17d00062)
> element (1193e1e0)
> Jan  7 22:05:18 kleineronkel kernel:   0: [d193e1e0] link (1193e210)
> e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0,
> PID=2d(SETUP) (buf=1f1fd2a0)
> Jan  7 22:05:18 kleineronkel kernel:   1: [d193e210] link (00000001)
> e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN)
> (buf=00000000)
> Jan  7 22:05:18 kleineronkel kernel:
> Jan  7 22:05:18 kleineronkel kernel: usb.c: USB device not accepting
> new address=8 (error=-110)
> 
> -- 
> Jörn Nettingsmeier     
> home://Kurfürstenstr.49.45138.Essen.Germany      
> phone://+49.201.491621
> http://spunk.dnsalias.org
> http://www.linuxdj.com/audio/lad/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
