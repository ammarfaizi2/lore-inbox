Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVEWPne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVEWPne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVEWPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:43:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:14556 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261895AbVEWPna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:43:30 -0400
Date: Mon, 23 May 2005 08:48:25 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050523154825.GB10774@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED388@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED388@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 09:52:05AM -0500, Abhay_Salunke@Dell.com wrote:
> Greg,
> > 
> > Also, what's wrong with using the existing firmware interface in the
> > kernel?
> request_firmware requires the $FIRMWARE env to be populated with the
> firmware image name or the firmware image name needs to be hardcoded
> within  the call to request_firmware. Since the user is free to change
> the BIOS update image at will, it may not be possible if we use
> $FIRMWARE also I am not sure if this env variable might be conflicting
> to some other driver.

As others have already stated, this doesn't really matter.  Make it
"dell_bios_update", if any device names their firmware that, well,
that's their problem...

thanks,

greg k-h
