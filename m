Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313366AbSC2F6z>; Fri, 29 Mar 2002 00:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313367AbSC2F6q>; Fri, 29 Mar 2002 00:58:46 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:36873 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313366AbSC2F6d>;
	Fri, 29 Mar 2002 00:58:33 -0500
Date: Thu, 28 Mar 2002 21:58:14 -0800
From: Greg KH <greg@kroah.com>
To: david@shepard.tc
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 Compile failure at datafab.c
Message-ID: <20020329055813.GE11727@kroah.com>
In-Reply-To: <20020328215320.1953.qmail@www4.nameplanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 01 Mar 2002 01:57:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 09:53:20PM -0000, david@shepard.tc wrote:
> I am attempting to add support for a USB Mass Storage device to kernel 2.5.7.
> Upon compile, I get the following errors:

Known problem, but thanks for reminding me.  I suggest just disabling
the following .config items:

	CONFIG_USB_STORAGE_DATAFAB
	CONFIG_USB_STORAGE_FREECOM
	CONFIG_USB_STORAGE_ISD200
	CONFIG_USB_STORAGE_DPCM
	CONFIG_USB_STORAGE_HP8200e
	CONFIG_USB_STORAGE_SDDR09
	CONFIG_USB_STORAGE_JUMPSHOT

thanks,

greg k-h
