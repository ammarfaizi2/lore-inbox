Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289341AbSBNBuv>; Wed, 13 Feb 2002 20:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289340AbSBNBum>; Wed, 13 Feb 2002 20:50:42 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:40970 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289338AbSBNBuW>;
	Wed, 13 Feb 2002 20:50:22 -0500
Date: Wed, 13 Feb 2002 17:46:23 -0800
From: Greg KH <greg@kroah.com>
To: Sanjeev Lakshmanan <survivor_eagles@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB device driver
Message-ID: <20020214014623.GA26045@kroah.com>
In-Reply-To: <20020213081956.12896.qmail@web14407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020213081956.12896.qmail@web14407.mail.yahoo.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 16 Jan 2002 23:41:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 12:19:56AM -0800, Sanjeev Lakshmanan wrote:
>  Hi all
>  
>  I need to develop a USB device driver for a custom
>  made switch. I shall give a brief description.
>  
>  The switch has four RJ 45 connectors for ethernet
>  cables and it needs to exchange data packets of size
>  8 bytes every .5 seconds. The Transmit ethernet
>  port(1,2,3,4) and Receive ethernet port(1,2,3,4)
>  need to be selected for each transfer and the data   
>   packet which is to be sent out and received on those
>    ports changes accordingly.

I don't see why you need a USB driver for a switch.  Where is USB in the
above description of your device?

>  Please let me know how I can start off writing the
>  code for  this driver.
>  Also please let me know if there are any SIMILAR
>  device drivers already developed and available.
>  
>  I am aware of the files
>  usr/src/linux/drivers/usb/usb.*
>  but as I have no prior experience with device
> drivers,  I am unable to start off.

I think your company needs to hire some people with device driver
experience :)

>  I have not yet subscribed to the list. PLease reply
> to  survivor_eagles@yahoo.com
> 
>  Regards,
>  Sanjeev.

Why did you post this to lkml and the linux-usb-users mailing lists from
two different accounts, using two different names?

Good luck,

greg k-h
