Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSBMTGz>; Wed, 13 Feb 2002 14:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSBMTGp>; Wed, 13 Feb 2002 14:06:45 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:51721 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288946AbSBMTGe>;
	Wed, 13 Feb 2002 14:06:34 -0500
Date: Wed, 13 Feb 2002 11:02:38 -0800
From: Greg KH <greg@kroah.com>
To: Nils Faerber <nils@kernelconcepts.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17[16] USB problem
Message-ID: <20020213190238.GB23933@kroah.com>
In-Reply-To: <20020213191651.5c3dfd5e.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020213191651.5c3dfd5e.nils@kernelconcepts.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 16 Jan 2002 16:42:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 07:16:51PM +0100, Nils Faerber wrote:
> Hi all!
> I recently see a strange USB problem which I find in 2.4.17 and 2.4.16 and
> maybe even earlier.
> What happens is that a special device attached via a USB HUB is not
> detected anymore, specifically usb.c claims that it cannot set the new
> address.
> The strange thing is:
> - It worked with that device (Brainboxes Bluetooth USB dongle) with
> earlier kernels.

This device is flawed.  I have had _lots_ of reports of this problem
with these devices.  Talk to Brainbox and ask if their devices have
passed the USB certification tests (odds are it hasn't :)

thanks,

greg k-h
