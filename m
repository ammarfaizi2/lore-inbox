Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266525AbRGDHeZ>; Wed, 4 Jul 2001 03:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266527AbRGDHeP>; Wed, 4 Jul 2001 03:34:15 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:4366 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266525AbRGDHd7>;
	Wed, 4 Jul 2001 03:33:59 -0400
Date: Wed, 4 Jul 2001 00:32:33 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.5 keyspan driver
Message-ID: <20010704003233.A30960@kroah.com>
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010703103800.B28180@kroah.com> <20010703171953.A16664@glitch.snoozer.net> <20010703174950.A593@glitch.snoozer.net> <20010703191655.A1714@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010703191655.A1714@glitch.snoozer.net>; from haphazard@socket.net on Tue, Jul 03, 2001 at 07:16:56PM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 07:16:56PM -0500, Gregory T. Norris wrote:
> In the hopes that it might prove helpful, I reran coldsync after
> loading usbserial.o and keyspan.o with the "debug=1" option.  Here's
> what was logged:

Can you try the keyspan_pda.o driver and see if it also gives you
problems?

I posted a patch to linux-usb-devel that should solve the "vendor symbol
not defined" bug for you.

thanks,

greg k-h
