Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSGXRcI>; Wed, 24 Jul 2002 13:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSGXRcI>; Wed, 24 Jul 2002 13:32:08 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:10503 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317431AbSGXRcH>;
	Wed, 24 Jul 2002 13:32:07 -0400
Date: Wed, 24 Jul 2002 10:35:05 -0700
From: Greg KH <greg@kroah.com>
To: Sven.Riedel@tu-clausthal.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keyboards with recent 2.4.19-pre/rcXX and 2.5.2X
Message-ID: <20020724173505.GE10124@kroah.com>
References: <20020724140026.GE9765@moog.heim1.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724140026.GE9765@moog.heim1.tu-clausthal.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 15:44:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 04:00:26PM +0200, Sven.Riedel@tu-clausthal.de wrote:
> Hi,
> USB keyboards don't work with recent 2.4.19-preXX (-pre2 works fine for
> me, but pre-10 and up don't), as well as int (at least) 2.5.25.
> The kernel does find the keyboard during bootup, but doesn't accept any
> keypresses. This happens regardless of the UHCI driver selected in
> 2.4.19 (normal or JE). 
> Input core support has been compiled in, as well as the full HID.
> Verified on one different machine.

Is CONFIG_USB_HIDINPUT selected in your .config?  You _did_ run 
'make oldconfig' when upgrading kernel versions, right?

thanks,

greg k-h
