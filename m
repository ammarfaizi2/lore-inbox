Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263253AbTCYTkk>; Tue, 25 Mar 2003 14:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263258AbTCYTkk>; Tue, 25 Mar 2003 14:40:40 -0500
Received: from vitelus.com ([64.81.243.207]:25103 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S263253AbTCYTkj>;
	Tue, 25 Mar 2003 14:40:39 -0500
Date: Tue, 25 Mar 2003 11:50:42 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Greg KH <greg@kroah.com>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Tweak to allow usb-midi to be built
Message-ID: <20030325195042.GJ22181@vitelus.com>
References: <20030325032133.GD22181@vitelus.com> <20030325032857.GA11874@kroah.com> <20030325033904.GE22181@vitelus.com> <20030325194744.GJ16847@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325194744.GJ16847@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 11:47:44AM -0800, Greg KH wrote:
> Ick, your email client ate all of the tabs in this file.  Can you try
> sending it again after changing the settings somewhere?
> 
> thanks,
> 
> greg k-h

It was probably my terminal. I don't think I'll ever get this right.
Just add obj-$(CONFIG_USB_MIDI) += class/ to drivers/usb/Makefile
