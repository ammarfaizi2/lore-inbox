Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265461AbRGBWpE>; Mon, 2 Jul 2001 18:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265462AbRGBWoz>; Mon, 2 Jul 2001 18:44:55 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:24843 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265461AbRGBWog>;
	Mon, 2 Jul 2001 18:44:36 -0400
Date: Mon, 2 Jul 2001 15:43:25 -0700
From: Greg KH <greg@kroah.com>
To: haphazard@socket.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: usbserial/keyspan module load race [was: 2.4.5 keyspan driver]
Message-ID: <20010702154325.B25063@kroah.com>
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010630133752.A850@glitch.snoozer.net> <20010701154910.A15335@glitch.snoozer.net> <01070200025204.05063@idun> <20010702172217.A2463@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010702172217.A2463@glitch.snoozer.net>; from haphazard@socket.net on Mon, Jul 02, 2001 at 05:22:17PM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 05:22:17PM -0500, Gregory T. Norris wrote:
> It wasn't quite as cooperative today, but after a few attempts I was
> able to reproduce it.
> 
>      root@glitch[~]# modprobe keyspan
>      Warning: /lib/modules/2.4.5/kernel/drivers/usb/serial/usbserial.o symbol for parameter vendor not found
>      Segmentation fault

What version of the modutils package do you have?

thanks,

greg k-h
