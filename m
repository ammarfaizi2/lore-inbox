Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVHPNhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVHPNhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVHPNhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:37:25 -0400
Received: from magic.adaptec.com ([216.52.22.17]:20427 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965211AbVHPNhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:37:23 -0400
Message-ID: <4301EC0E.6090406@adaptec.com>
Date: Tue, 16 Aug 2005 09:37:18 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James.Smart@Emulex.Com
CC: James.Bottomley@SteelEye.com, matthew@wil.cx, greg@kroah.com,
       akpm@osdl.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk
Subject: Re: [PATCH] add transport class symlink to device object
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD39@xbl3.ma.emulex.com>
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD39@xbl3.ma.emulex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 13:35:03.0479 (UTC) FILETIME=[4EA67470:01C5A267]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/05 20:52, James.Smart@Emulex.Com wrote:
> Actually, I view this as being a little odd...
> 
> What is "0000:00:04:0" in this case ? The "device" is not a serial
> port, which is what the ttyXX back link would lead you to believe.
> Thus, it's a serial port multiplexer that supports up to N ports,
> right ? and wouldn't the more correct representation have been to
> enumerate a device for each serial port ? (e.g. 0000:00:04.0/line0,
> 0000:00:04.0/line1, or similar)
> 
> Think if SCSI used this same style of representation. For example,
> if there was no scsi target device entity, but class entities did
> exist and they just pointed back to the scsi host device entry.
> 
> My vote is to make the multiplexor instantiate each serial line
> as a separate device.

Hi James,

Yes, you're absolutely and completely correct.  I think the same
way as you do.

	Luben

