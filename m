Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbSKSWrb>; Tue, 19 Nov 2002 17:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbSKSWrb>; Tue, 19 Nov 2002 17:47:31 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:54742 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267536AbSKSWra> convert rfc822-to-8bit; Tue, 19 Nov 2002 17:47:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Brad Hards <bhards@bigpond.net.au>,
       "Folkert van Heusden" <folkert@vanheusden.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: local link configuration daemon?
Date: Tue, 19 Nov 2002 23:51:50 +0100
User-Agent: KMail/1.4.3
References: <003b01c28fed$724a2c80$3640a8c0@boemboem> <200211191827.10622.oliver@neukum.name> <200211200815.56896.bhards@bigpond.net.au>
In-Reply-To: <200211200815.56896.bhards@bigpond.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211192351.50618.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It was originally done by Sebastian Kuzminsky. It basically uses the
> kernel's packet filter (BPF) and socket code, via Libnet and libpcap. You
> can get it from your friendly kernel.org mirror
> (http://www.XX.kernel.org/pub/software/network/zcip/, where XX is your
> country code).
>
> In the longer term, it might be appropriate to move some of it (the defend
> part of the claim-and-defend sequence) into kernel space. I don't think it
> makes sense to have it all in kernel space.

Definitely, however you've never convinced me how you do the arp related
part in user space at all. It seems to me that you cannot do that unless
you take all arp handling into user space.

	Regards
		Oliver

