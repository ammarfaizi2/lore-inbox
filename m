Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289482AbSA2K6u>; Tue, 29 Jan 2002 05:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289490AbSA2K6k>; Tue, 29 Jan 2002 05:58:40 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:40199 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289484AbSA2K6d>;
	Tue, 29 Jan 2002 05:58:33 -0500
Date: Mon, 28 Jan 2002 12:52:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: mochel@osdl.org, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB
Message-ID: <20020128125204.A72@toy.ucw.cz>
In-Reply-To: <20020125021435.GA22080@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020125021435.GA22080@kroah.com>; from greg@kroah.com on Thu, Jan 24, 2002 at 06:14:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> .
> --- root
>     --- pci0
>         |-- 00:00.0
>         |   |-- power
>         |   --- status
>         |-- 00:01.0
>         |   |-- power
>         |   --- status
>         |-- 00:1e.0
>         |   |-- power
>         |   --- status
>         |-- 00:1f.0
>         |   |-- power
>         |   --- status
>         |-- 00:1f.1
>         |   |-- power
>         |   --- status
>         |-- 00:1f.2
>         |   |-- power
>         |   --- status
>         |-- 00:1f.3
>         |   |-- power
>         |   --- status
>         |-- 00:1f.5
>         |   |-- power
>         |   --- status
>         |-- pci1
>         |   |-- 01:08.0
>         |   |   |-- power
>         |   |   --- status
>         |   |-- 01:0d.2
>         |   |   |-- power
>         |   |   --- status
>         |   --- usb
>         |       |-- 002
>         |       |   |-- power
>         |       |   --- status
>         |       --- 003
>         |           |-- power
>         |           --- status
>         |-- pci2
>         |   --- 02:00.0
>         |       |-- power
>         |       --- status
>         --- usb
>             --- 002
>                 |-- power
>                 --- status

Should not usb bus hang off some pci device (uhci/ohci?)

						Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

