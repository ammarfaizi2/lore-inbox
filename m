Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284780AbRLEWhI>; Wed, 5 Dec 2001 17:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284778AbRLEWg7>; Wed, 5 Dec 2001 17:36:59 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:25082 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S284773AbRLEWgu>; Wed, 5 Dec 2001 17:36:50 -0500
Message-ID: <3C0E90C0.A1738C8C@monmouth.com>
Date: Wed, 05 Dec 2001 16:25:20 -0500
From: Dipak <dipak@monmouth.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-6.1smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Romain Giry <romain_giry@yahoo.fr>
CC: mlist-linux-kernel@NNTP-SERVER.CALTECH.EDU
Subject: Re: 
In-Reply-To: <5.0.2.1.0.20011205170157.01a7ae98@pop.mail.yahoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Romain Giry wrote:

Hi,


> Hi
>
> i would like to know how the network layer does to know what is the upper
> layer protocol in order to fill in correctly the protocol field in the
> header it adds to the packet before sending it.

see, their might be either API provided by DLL (ethernet, ATM, FR etc) to
network layer (IP, IPX etc) to sent packets over a physical device. Now, the
Network protocol field can be passed through the API to be filled in by
DLL header by DLL. Another case may be, DLL can easily know what's the ifIndex
the packet is coming from. Network layer might have registration policy by
ifIndex to DLL, which can be used now to infer Network layer protocol id.

> I'm doing a ethernet device
> that doesn't add any header to the packet but change the output device,
> then i should say the network device that the packet is like if it has been
> sent by the ip protocol.

I didn't understand what did you mean by "ethernet device doesn't add any
header but change the output device"? May be after you explain a bit more I
can suggest something more.

Thanks,
Dipak

>
>
> Thanks,
>
> Romain Giry
>
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

