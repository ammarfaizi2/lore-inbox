Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSFKHrl>; Tue, 11 Jun 2002 03:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSFKHrU>; Tue, 11 Jun 2002 03:47:20 -0400
Received: from [195.157.147.30] ([195.157.147.30]:58893 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S316898AbSFKHqZ>; Tue, 11 Jun 2002 03:46:25 -0400
Date: Tue, 11 Jun 2002 08:47:27 +0100
From: Sean Hunter <sean@uncarved.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth 'depredation'
Message-ID: <20020611084727.A5997@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D05AA6E.mailKB1BHA1W@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Build a kernel with traffic classifaction and CBQ, and use "tc".

See the howtos.

Sean

On Tue, Jun 11, 2002 at 09:44:46AM +0200, DervishD wrote:
>     Hello all :))
>     
>     I've noticed that, when using certain programs like 'wget', the
> bandwidth seems to be 'depredated' by them. When I download a file
> with lukemftp or with links, the bandwidth is then distributed
> between all IP clients, but when using wget or some ftp clients, it
> is not distributed. BTW, I'm using an ADSL line (128 up / 256 down).
> 
>     IMHO, the IP layer (well, in this case the TCP layer) should
> distribute the bandwidth (although I don't know how to do this), and
> the kernel seems to be not doing it.
> 
>     I don't know if this is the intended behaviour or even if this is
> a kernel fault or not, but I think that is not good ;)
> 
>     Thanks :)
>     Raúl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
