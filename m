Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRBLRtM>; Mon, 12 Feb 2001 12:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRBLRtC>; Mon, 12 Feb 2001 12:49:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:29946 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S129364AbRBLRsy>;
	Mon, 12 Feb 2001 12:48:54 -0500
Date: Mon, 12 Feb 2001 15:51:45 -0200 (EST)
From: Fernando Fuganti <fuganti@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Christian Ullrich <chris@chrullrich.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1: Abnormal interrupt from RTL8139
In-Reply-To: <3A874CB4.717C101C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0102121508390.814-100000@ze.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've had some problems with this card, as Aristeu Rozanski have asked you
(Jeff) for some news about driver development...

we have some machines that did some random reboot or card lockups:
- rtl8139.c, card lockup
- (2.2.17) 8139too.c, machine reboot
- (2.2.18) 8139too.c (0.9.12-2.2 - PIO mode), machine reboot

we are testing new version with MMIO mode to find out what is wrong
(until now, it seems to be stable)

If you want, I could get more info or testing something else, ok ?


Fernando Fuganti


On Sun, 11 Feb 2001, Jeff Garzik wrote:

> Christian Ullrich wrote:
> > I'm getting some of these messages in syslog:
> > Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
> > Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
> > Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000020.
> > Feb  7 17:32:53 christian kernel: eth0: Abnormal interrupt, status 00000041.
> [...]
> > I have not observed any effects related to these messages.
> 
> Those messages are logged at the debugging level... if they bother you,
> don't log kern.debug...
> 
> 	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
