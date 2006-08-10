Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWHJGXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWHJGXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWHJGXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:23:39 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:55504 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161075AbWHJGXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:23:38 -0400
Date: Thu, 10 Aug 2006 08:20:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jeff@garzik.org>
cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
In-Reply-To: <44DACE9F.3090909@garzik.org>
Message-ID: <Pine.LNX.4.61.0608100819360.10926@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain> <44DA4288.6020806@rtr.ca>
 <44DACE9F.3090909@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This will also allow time for things like "udev" to perhaps think about
>> an option to someday provide /dev/hd* symlinks for PATA devices when
>> libata is used instead of IDE (?).  That might be a possible migration
>> path in the far future.
>
> Unfortunately a symlink won't work because of compatibility issues. /dev/hd
> supports more partitions, and a different set of ioctls.

I think apps should not rely on the name specifying whether a device is 
IDE/SCSI. After all, udev names like "/by-id/..." don't tell anything 
about device type whatsoever, like "hda"/"sda" do.



Jan Engelhardt
-- 
