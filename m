Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSFKNSH>; Tue, 11 Jun 2002 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSFKNSG>; Tue, 11 Jun 2002 09:18:06 -0400
Received: from denise.shiny.it ([194.20.232.1]:430 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S317036AbSFKNSG>;
	Tue, 11 Jun 2002 09:18:06 -0400
Message-ID: <XFMail.20020611151754.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3D05AA6E.mailKB1BHA1W@viadomus.com>
Date: Tue, 11 Jun 2002 15:17:54 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: DervishD <raul@pleyades.net>
Subject: RE: bandwidth 'depredation'
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11-Jun-2002 DervishD wrote:
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

No, IP doesn't balance anything. You have to filter the traffic with
QoS of traffic shapers to give different "priorities" to packets as
you like. Wget doesn't "grab" the bandwidth, it's the remote server
that fills it.


Bye.

