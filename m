Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVKGSru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVKGSru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVKGSru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:47:50 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:6563 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S964913AbVKGSrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:47:49 -0500
Message-ID: <436FA15F.6050701@free.fr>
Date: Mon, 07 Nov 2005 19:47:59 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <43691E7E.5090902@free.fr> <20051107174621.GD17004@kroah.com>
In-Reply-To: <20051107174621.GD17004@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH wrote:

>>Thanks, but does userspace will retry if it fails the first time ?
>>The device needs the firmware quickly and after 3-5 seconds without it, 
>>it goes berserk.
> 
> 
> That sounds like a pretty broken device :)
If it was only that (don't work in bulk mode with down rate > 3Mbps ; 
empty iso urb report errors, ...)...



> This isn't BSD :)
> 
 > It's ok, as long as it is local, and it is what you want to do.  I don't
 > have a strong feeling toward it.

I finally merge them like other usbatm driver did.


The corrected version is ready, I will wait some time in order others 
developers could do final checking.
I will send it this evening or tomorrow.


Thanks

Matthieu
