Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423742AbWKIB6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423742AbWKIB6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161785AbWKIB6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:58:32 -0500
Received: from wacom-nt10.wacom.com ([204.119.25.43]:64533 "EHLO
	wacom-nt10.wacom.com") by vger.kernel.org with ESMTP
	id S1161783AbWKIB6c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:58:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Typo in drivers/usb/input/wacom_wac.c?
Date: Wed, 8 Nov 2006 17:58:30 -0800
Message-ID: <6753EB6004AFF34FAA275742C104F95201758D@wacom-nt10.wacom.com>
From: "Ping Cheng" <pingc@wacom.com>
To: "Greg KH" <greg@kroah.com>, "Andrew Benton" <b3nt@supanet.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two wacom_be16_to_cpu are in wacom_intuos_irq, which has nothing to do with Volito2. Volito2 uses wacom_graphire_irq. I am not exactly sure what Andrew's problem is. 

Andrew, please surf the discussion forum at http://linuxwacom.sourceforge.net/ to see if there is anything similiar to your problem.

Ping

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, November 08, 2006 7:19 AM
To: Andrew Benton; Ping Cheng
Cc: Linux Kernel Mailing List
Subject: Re: Typo in drivers/usb/input/wacom_wac.c?


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
