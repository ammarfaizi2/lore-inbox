Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132152AbRDJOqb>; Tue, 10 Apr 2001 10:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRDJOqY>; Tue, 10 Apr 2001 10:46:24 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:13843 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132127AbRDJOqO>;
	Tue, 10 Apr 2001 10:46:14 -0400
Date: Tue, 10 Apr 2001 10:46:05 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Ofer Fryman <ofer@shunra.co.il>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-net@vger.kernel.org'" <linux-net@vger.kernel.org>
Subject: RE: network cards (drivers) performance.
In-Reply-To: <F1629832DE36D411858F00C04F24847A11DF8C@SALVADOR>
Message-ID: <Pine.LNX.4.30.0104101044460.28062-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I used 1024 byte IP packet size (+12 bytes of Ethernet header) under 1500
MTU.

On Tue, 10 Apr 2001, Ofer Fryman wrote:

> At what frame size?.
>
> Thanks
> Ofer
>
> -----Original Message-----
> From: Bart Trojanowski [mailto:bart@jukie.net]
> Sent: Tuesday, April 10, 2001 4:30 PM
> To: Ofer Fryman
> Cc: 'linux-kernel@vger.kernel.org'; 'linux-net@vger.kernel.org'
> Subject: Re: network cards (drivers) performance.
>
>
> On Tue, 10 Apr 2001, Ofer Fryman wrote:
>
> > Has any one tested the performance of the Tulip or AMD cards (or any other
> > network card) on any Linux version, with any CPU and any chip-set?
>
> Wow... that's a pretty broad question!
>
> Yes I have had very good performance with the 'recent' tulip cards:
>
> # lspci | grep DECchip
> 04:08.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
> (rev 41)
> 04:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
> (rev 41)
>
> I have been able to tunnel about 186 Mbits/s on a P3Xeon/866 on any
> 2.4.{1,3}
> kernel with two of the above cards (tulip driver).  Note that this means
> full duplex was on and the box was forwarding a total of 186 MBits of data
> fron one NIC to another; actually it was 93 in each direction.  Fast
> routing (a la CONFIG_NET_FASTROUTE) was _not_ compiled into the kernel.
>
> B.
>
>

-- 
	WebSig: http://www.jukie.net/~bart/sig/


