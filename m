Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266348AbVBDRwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbVBDRwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263899AbVBDRj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:39:58 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:1438 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S266041AbVBDRhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:37:34 -0500
Message-ID: <4203B2D9.7080904@free.fr>
Date: Fri, 04 Feb 2005 18:37:29 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] PNP support for i8042 driver
References: <41960AE9.8090409@free.fr> <20041117100745.GA1387@ucw.cz>
In-Reply-To: <20041117100745.GA1387@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Vojtech Pavlik wrote:
> On Sat, Nov 13, 2004 at 02:23:53PM +0100, matthieu castet wrote:
> 
>>Hi,
>>this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
>>is try before the pnp driver so if you don't disable ACPI or apply 
>>others pnpacpi patches, it won't change anything.
>>
>>Please review it and apply if possible
> 
> 
> Ok, my thoughts on this:
> 
> 	It's OK to keep the device allocated to this driver via the PnP
>         subsystem, and not bother with releasing the code via
> 	__initcall.
> 
> 	I agree that if there is a way to enumerate the device, (like
> 	PnP, ACPI or OpenFirmware), we should use that instead of
> 	probing and using a platform device for the controller.
> 
> 	I think that we should drop the ACPI support from i8042, in
> 	favor of pnpacpi, because PnP is more generic and if the
>  	keyboard device was listed in PnPBIOS instead of ACPI, it'll
> 	still work.
> 
Any news about this ?


Matthieu CASTET
