Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270932AbRHNXPH>; Tue, 14 Aug 2001 19:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270931AbRHNXO6>; Tue, 14 Aug 2001 19:14:58 -0400
Received: from [207.21.185.24] ([207.21.185.24]:25860 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S270921AbRHNXOo>; Tue, 14 Aug 2001 19:14:44 -0400
Message-ID: <3B79B0F9.825E02A9@lnxw.com>
Date: Tue, 14 Aug 2001 16:15:05 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: cwidmer@iiic.ethz.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: checksumming on a DP83820
In-Reply-To: <01081417581000.04104@asterix>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver i have in my hands says UDP checksumming might
be broken. It is pretty crappy driver which most likely
will not work on anything else than x86. It is written
with only 2.2 kernels in mind. The manual i have is from
feb/2001 and is preliminary :-)

I think it is 1) - yes, 2) - no



later,
Petko

Christian Widmer wrote:
> 
> does anybody know the DP83820 which is used on the GigaNix NIC and
> can awnser me the folloing question or knows where to ask.
> 
> the DP83820 supports IP/UDP/TCP checksumming. the chip docu say you
> can mark the transmit descriptior when it contains a IP, UDP, TCP header.
> 1) is it possible for udp to spread multiple descriptios and the checksum
>    will be calculated?
> 2) if so can it be bigger than a jumboframe?
> 
> i don't find any awnsers in the chip docu from national. i think 1) could be
> possible but 2) not. am i right?
> 
> thanks
> chris
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
