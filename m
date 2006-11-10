Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946670AbWKJPMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946670AbWKJPMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946704AbWKJPMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:12:33 -0500
Received: from mail.syneticon.net ([213.239.212.131]:60047 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1946670AbWKJPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:12:33 -0500
Message-ID: <455496CA.5040405@wpkg.org>
Date: Fri, 10 Nov 2006 16:12:10 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: madduck@madduck.net
Subject: Re: scary messages: HSM violation during boot of 2.6.18/amd64
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, I just upgraded my workstation to 2.6.18.2. It has four SATA
> drives in a RAID10, connected to the system in pairs on Promise and
> Via on-board controllers.
> 
> Now on every boot, I see several messages like this for the drives
> connected to the VIA controller (VT6420):
> 
>   ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>   ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
>   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>   ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
> 
> What do these mean?
> 
> Also, for the first of the two drives on the Promise/FastTrak
> PDC20378 controller, I see messages like this:
> 
>   ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
> 
> What about those?
> 
> I saw none of that under 2.6.17.x. Should I be worried?

I saw similar when using smartctl / smartd with wrong options (without 
-d ata; in short, smartd tried to talk "IDE language" to SATA device...).


-- 
Tomasz Chmielewski
http://wpkg.org

