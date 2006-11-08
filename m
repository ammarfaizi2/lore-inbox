Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423983AbWKIBFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423983AbWKIBFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423984AbWKIBFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:05:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:28556 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1423983AbWKIBFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:05:09 -0500
Date: Thu, 9 Nov 2006 00:19:07 +0900
From: Greg KH <greg@kroah.com>
To: Andrew Benton <b3nt@supanet.com>, pingc@wacom.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Typo in drivers/usb/input/wacom_wac.c?
Message-ID: <20061108151907.GA21450@kroah.com>
References: <4551A981.60709@supanet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4551A981.60709@supanet.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 09:55:13AM +0000, Andrew Benton wrote:
> Hello World,
> my Wacom Volito2 tablet doesn't work with the kernel driver as it is. 
> The cursor jitters about at the bottom of the screen in a useless 
> manner. However, if I edit drivers/usb/input/wacom_wac.c and change the 
> two instances of wacom_be16_to_cpu to wacom_le16_to_cpu then it works 
> perfectly
> 
> sed -i 's/_b/_l/' drivers/usb/input/wacom_wac.c

Which kernel version are you referring to?

Ping, any thoughts?

thanks,

greg k-h
