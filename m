Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279797AbRKFQ4L>; Tue, 6 Nov 2001 11:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279788AbRKFQzw>; Tue, 6 Nov 2001 11:55:52 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:27912 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S279797AbRKFQzp>;
	Tue, 6 Nov 2001 11:55:45 -0500
Date: Tue, 6 Nov 2001 09:55:27 -0800
From: Greg KH <greg@kroah.com>
To: Stephan Gutschke <stephan@gutschke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011106095527.A10279@kroah.com>
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE7F362.1090406@gutschke.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 09 Oct 2001 16:53:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 03:27:46PM +0100, Stephan Gutschke wrote:
> Hi Greg,
> 
> the output is below, I also added a couple of debug-lines in the
> visor_open() function. Seems to me like port->read_urb is null and
> maybe that shouldn't be?

Hm, yes, port->read_urb should _NOT_ be NULL.  Thanks for adding this
check.

Can you send the output of /proc/bus/usb/devices right after you press
the sync button on the Clie?  Don't try syncing :)

thanks,

greg k-h
