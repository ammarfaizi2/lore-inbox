Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSF0Rv7>; Thu, 27 Jun 2002 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSF0Rv6>; Thu, 27 Jun 2002 13:51:58 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:24839 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316899AbSF0Rv5>;
	Thu, 27 Jun 2002 13:51:57 -0400
Date: Thu, 27 Jun 2002 10:53:56 -0700
From: Greg KH <greg@kroah.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB doesn't work
Message-ID: <20020627175356.GA10905@kroah.com>
References: <200206271503.31851.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206271503.31851.roy@karlsbakk.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 30 May 2002 16:49:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2002 at 03:03:31PM +0200, Roy Sigurd Karlsbakk wrote:
> usb-ohci.c: USB OHCI at membase 0xc4802000, IRQ 10
> usb-ohci.c: usb-00:13.0, Compaq Computer Corporation ZFMicro Chipset USB
> usb-ohci.c: USB HC TakeOver failed!
> usb.c: USB bus -1 deregistered

Looks like your BIOS doesn't want to give up the USB controller.  Is
there any USB settings in the BIOS that you can change?

greg k-h
