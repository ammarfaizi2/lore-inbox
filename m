Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283662AbRK3PFw>; Fri, 30 Nov 2001 10:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283664AbRK3PFm>; Fri, 30 Nov 2001 10:05:42 -0500
Received: from smtp-abo-3.wanadoo.fr ([193.252.19.152]:41404 "EHLO
	andira.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S283662AbRK3PF3>; Fri, 30 Nov 2001 10:05:29 -0500
Date: Fri, 30 Nov 2001 16:05:19 +0100
From: Edouard Gomez <ed.gomez@wanadoo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb slow in >2.4.10
Message-ID: <20011130160519.A1820@wanadoo.fr>
In-Reply-To: <20011130040719.A21515@elch.elche> <20011129202959.B8633@kroah.com> <20011130141616.B25328@elch.elche>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130141616.B25328@elch.elche>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 02:16:16PM +0100, Armin Obersteiner wrote:

> 
> Nov 24 12:52:21 elch kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
> Nov 24 12:52:21 elch kernel: uhci.c: USB UHCI at I/O 0xd000, IRQ 9
> Nov 24 12:52:21 elch kernel: uhci.c: detected 2 ports
> 

Hi,

  I've experienced the same slowdown problem with Alcatel Speedtouch USB modem.
It should run fine again if you use the usb-uhci module instead of uhci.

 I think something is broken in uhci.c since 2.4.10. Many users of the
speedtouch usb modem wrote to our ML to report such a problem. All users
were using uhci. I've done some basic tests and uhci was responsible of the
slowndown. 2.4.11 solved the timeouts problems, but the slowdown has not been
solved yet.

-- 
Edouard Gomez
http://perso.wanadoo.fr/ed.gomez
