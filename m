Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWHIAT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWHIAT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWHIAT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:19:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:25440 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030367AbWHIAT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:19:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=gbwI0brR7uxbeXZ3c2swpYLJM9AooaZofyneryOIjyN5fAy31bTVWCaZ/6htAE9SyBGuzuvSQ/xWHWDA1c+Ms81IJLWv5Dl1625FIn5bccdcCDynRZ+IpvrHZG2xjoL3NU1yMovyrY2ki9hP6DFUBl+3jEnZdie4u0Kr0EkxiOk=
Date: Wed, 9 Aug 2006 02:19:45 +0200
From: Diego Calleja <diegocg@gmail.com>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       mchehab@infradead.org, akpm@osdl.org
Subject: Re: [PATCH 12/14] V4L/DVB (4430): Quickcam_messenger compilation
 fix
Message-Id: <20060809021945.043f9ecb.diegocg@gmail.com>
In-Reply-To: <20060808210654.PS54412700012@infradead.org>
References: <20060808210151.PS78629800000@infradead.org>
	<20060808210654.PS54412700012@infradead.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 08 Aug 2006 18:06:54 -0300,
mchehab@infradead.org escribió:

> --- a/drivers/media/video/Makefile
> +++ b/drivers/media/video/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_USB_ZC0301)        += zc030
>  obj-$(CONFIG_USB_IBMCAM)        += usbvideo/
>  obj-$(CONFIG_USB_KONICAWC)      += usbvideo/
>  obj-$(CONFIG_USB_VICAM)         += usbvideo/
> +obj-$(CONFIG_USB_QUICKCAM_MESSENGER)	+= usbvideo/

This one has already been picked up by akpm
