Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283690AbRK3Psf>; Fri, 30 Nov 2001 10:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283685AbRK3PsZ>; Fri, 30 Nov 2001 10:48:25 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:57864 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S283689AbRK3PsN>;
	Fri, 30 Nov 2001 10:48:13 -0500
Date: Fri, 30 Nov 2001 07:47:53 -0800
From: Greg KH <greg@kroah.com>
To: Armin Obersteiner <armin@xos.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb slow in >2.4.10
Message-ID: <20011130074753.C9866@kroah.com>
In-Reply-To: <20011130040719.A21515@elch.elche> <20011129202959.B8633@kroah.com> <20011130141616.B25328@elch.elche>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130141616.B25328@elch.elche>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 02 Nov 2001 06:47:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 02:16:16PM +0100, Armin Obersteiner wrote:
> 
> Nov 24 12:52:21 elch kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
> Nov 24 12:52:21 elch kernel: uhci.c: USB UHCI at I/O 0xd000, IRQ 9
> Nov 24 12:52:21 elch kernel: uhci.c: detected 2 ports

You're using the uhci driver.  Can you try and see if you have the same
problem with the usb-uhci driver?  The uhci driver had some big changes
right around the time that you have reported things slowing down.

thanks,

greg k-h
