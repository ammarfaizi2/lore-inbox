Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVKANxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVKANxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKANxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:53:34 -0500
Received: from plasma-gate.weizmann.ac.il ([132.77.150.54]:42168 "EHLO
	plasma-gate.weizmann.ac.il") by vger.kernel.org with ESMTP
	id S1750788AbVKANxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:53:33 -0500
Message-ID: <4367734E.6050600@weizmann.ac.il>
Date: Tue, 01 Nov 2005 15:53:18 +0200
From: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Organization: Weizmann Institute of Science
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix floppy.c to store correct ro/rw status in underlying
 gendisk
References: <4363B081.7050300@jonmasters.org> <35fb2e590510291035n297aa22cv303ae77baeb5c213@mail.gmail.com> <43660693.6040601@weizmann.ac.il> <200510311717.21676.rob@landley.net>
In-Reply-To: <200510311717.21676.rob@landley.net>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> But yeah, we're sticklers for correct behavior, and only attempt to remount 
> readonly if we get EACCES or EROFS, not _just_ because we attempted a 
> read/write mount and it failed.

BTW, busybox doesn't agree to do just mount -o remount,... /mountpoint, 
it wants also either the device name passed or the entry be present in 
fstab.

Regards,

Evgeny
