Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbVHPNld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbVHPNld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVHPNlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:41:32 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1486 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965217AbVHPNlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:41:31 -0400
Message-ID: <4301ED06.1020209@adaptec.com>
Date: Tue, 16 Aug 2005 09:41:26 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: James.Smart@Emulex.Com, matthew@wil.cx, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] add transport class symlink to device object
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD39@xbl3.ma.emulex.com> <1124154494.5089.86.camel@mulgrave>
In-Reply-To: <1124154494.5089.86.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 13:39:11.0543 (UTC) FILETIME=[E2820470:01C5A267]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/05 21:08, James Bottomley wrote:
>>Think if SCSI used this same style of representation. For example,
>>if there was no scsi target device entity, but class entities did
>>exist and they just pointed back to the scsi host device entry.
> 
> 
> Yes, it's theoretically possible to have had SCSI do this.  We didn't do
> it at the time because class_devices didn't exist when the SCSI tree was
> first put together.  It would, however, have rather put the mockers on
> doing transport classes since class devices can't point at other class
> devices.

Well, so be it.

All in all, I'd like to point out that James S has a very good
and valid point, as anyone trained in SCSI protocols can see.

>>My vote is to make the multiplexor instantiate each serial line
>>as a separate device.
> 
> That's a choice that's up to the maintainer of the serial driver ...

I think James S, was making a point of concept.  Maybe SCSI Core can
learn from this?

	Luben
