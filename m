Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265980AbRGDREh>; Wed, 4 Jul 2001 13:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265997AbRGDRE1>; Wed, 4 Jul 2001 13:04:27 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:39943 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265980AbRGDREW>; Wed, 4 Jul 2001 13:04:22 -0400
Date: Wed, 4 Jul 2001 12:04:04 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.5 keyspan driver
Message-ID: <20010704120404.A529@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010703103800.B28180@kroah.com> <20010703171953.A16664@glitch.snoozer.net> <20010703174950.A593@glitch.snoozer.net> <20010703191655.A1714@glitch.snoozer.net> <20010704003233.A30960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010704003233.A30960@kroah.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.6 #1 Wed Jul 4 11:31:46 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated to 2.4.6, and applied the patch from linux-usb-devel.  The
keyspan_pda driver doesn't seem to detect the device at all.  The
keyspan driver detects it and creates /dev/usb/tts/0, but shows the
same problems as before.


On Wed, Jul 04, 2001 at 12:32:33AM -0700, Greg KH wrote:
> On Tue, Jul 03, 2001 at 07:16:56PM -0500, Gregory T. Norris wrote:
> > In the hopes that it might prove helpful, I reran coldsync after
> > loading usbserial.o and keyspan.o with the "debug=1" option.  Here's
> > what was logged:
> 
> Can you try the keyspan_pda.o driver and see if it also gives you
> problems?
> 
> I posted a patch to linux-usb-devel that should solve the "vendor symbol
> not defined" bug for you.
> 
> thanks,
> 
> greg k-h
