Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318449AbSGSDeF>; Thu, 18 Jul 2002 23:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318450AbSGSDeF>; Thu, 18 Jul 2002 23:34:05 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:15879 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318451AbSGSDeE>;
	Thu, 18 Jul 2002 23:34:04 -0400
Date: Thu, 18 Jul 2002 20:35:39 -0700
From: Greg KH <greg@kroah.com>
To: Josh Litherland <fauxpas@temp123.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keypad
Message-ID: <20020719033539.GB18456@kroah.com>
References: <20020719015232.GA20956@temp123.org> <20020719031000.GA18382@kroah.com> <20020719032008.GA22934@temp123.org> <20020719032445.GA18456@kroah.com> <20020719033005.GA23021@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719033005.GA23021@temp123.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 02:16:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:30:05PM -0400, Josh Litherland wrote:
> On Thu, Jul 18, 2002 at 08:24:45PM -0700, Greg KH wrote:
> 
> > If the device is detected, how is it detected?  Is the USB HID driver
> > binding to the device?
> 
> hub.c: USB new device connect on bus1/1, assigned device number 4
> input0: USB HID v1.00 Keyboard [        USB Keypad                    ] on usb1:4.0

Looks good to me (from a USB subsystem standpoint.)  As for why it's not
working for you, I don't know.  Perhaps it's spitting out keycodes that
you're not expecting to see.

Good luck,

greg k-h
