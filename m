Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWDLVmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWDLVmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWDLVmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:42:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10672 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932318AbWDLVmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:42:15 -0400
Date: Wed, 12 Apr 2006 14:41:08 -0700
From: Greg KH <gregkh@suse.de>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is platform_device_register_simple() deprecated?
Message-ID: <20060412214108.GA12480@suse.de>
References: <443D3DED.5030009@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443D3DED.5030009@keyaccess.nl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 07:50:37PM +0200, Rene Herman wrote:
> Hi Greg, Russel, Dmitry.
> 
> ALSA is using platform_device_register_simple(). Jean Delvare pointed:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113398060508534&w=2
> 
> out, where _simple looks to be slated for removal. Is this indeed the 
> case? ALSA isn't using the resources -- doing a manual alloc/add would 
> not be a problem...

Great, care to convert ALSA to use the proper api so we can remove
platform_device_register_simple()?

thanks,

greg k-h
