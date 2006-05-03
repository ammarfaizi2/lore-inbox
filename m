Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWECRp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWECRp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 13:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWECRp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 13:45:29 -0400
Received: from ns1.suse.de ([195.135.220.2]:47766 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030270AbWECRp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 13:45:28 -0400
Date: Wed, 3 May 2006 10:43:49 -0700
From: Greg KH <greg@kroah.com>
To: Razvan Gavril <razvan.g@plutohome.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftdi_sio: ACT Solutions HomePro ZWave interface
Message-ID: <20060503174349.GA3098@kroah.com>
References: <44572749.6090103@plutohome.com> <20060502200532.GA8172@kroah.com> <44589FB0.6090909@plutohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44589FB0.6090909@plutohome.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 03:18:56PM +0300, Razvan Gavril wrote:
> Greg KH wrote:
> >On Tue, May 02, 2006 at 12:32:57PM +0300, Razvan Gavril wrote:
> >
> >Care to diff this against 2.6.17-rc3?  Lots of ftdi new device ids have
> >been added there.
> >
> >You also forgot to add a "Signed-off-by:" line :(
> 
> Signed-Off By: Razvan Gavril <razvan.g@plutohome.com>

Care to add a good text for what the patch does?

> ---
> 
> diff -Nur linux-2.6.17-rc3-orig/drivers/usb/serial/ftdi_sio.c 
> linux-2.6.17-rc3/drivers/usb/serial/ftdi_sio.c
> --- linux-2.6.17-rc3-orig/drivers/usb/serial/ftdi_sio.c 2006-05-03 
> 15:12:01.000000000 +0300

The patch is line wrapped :(

> +++ linux-2.6.17-rc3/drivers/usb/serial/ftdi_sio.c      2006-05-03 
> 15:04:39.000000000 +0300
> @@ -307,6 +307,7 @@
> 
> 
> static struct usb_device_id id_table_combined [] = {
> +       { USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
>        { USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
>        { USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
>        { USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },

And the tabs were stripped by your email client :(

Care to try again?

thanks,

greg k-h
