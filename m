Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSLPOGY>; Mon, 16 Dec 2002 09:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSLPOGY>; Mon, 16 Dec 2002 09:06:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35037
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266771AbSLPOGX>; Mon, 16 Dec 2002 09:06:23 -0500
Subject: Re: 2.4.21-pre1 broke the ide-tape driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: m.c.p@wolk-project.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200212152338.AAA24823@harpo.it.uu.se>
References: <200212152338.AAA24823@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 14:53:33 +0000
Message-Id: <1040050413.13787.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-15 at 23:38, Mikael Pettersson wrote:
> 
> On Sun, 15 Dec 2002 02:23:34 +0100, Marc-Christian Petersen wrote:
> >> Kernel 2.4.21-pre1 broke the ide-tape driver: the driver
> >> now hangs during initialisation. 2.2 kernels (with Andre's
> >> IDE patch) and 2.4 up to 2.4.20 do not have this problem.
> >> My box has a Seagate STT8000A ATAPI tape drive as hdd;
> >> hdc is a Philips CD-RW, and the controller is ICH2 (i850 chipset).
> >http://linux.bkbits.net:8080/linux-2.4/patch@1.828?nav=index.html|ChangeSet@-7d|cset@1.828
> 
> Addendum: this patch fixes the init-time hang, and ide-tape does
> seem to work fine, but 'rmmod ide-tape' oopses -- 2.4.20-ac2 also
> oopses on 'rmmod ide-tape'.

I don't unfortunately have any ide-tape devices. I'll take a look though

