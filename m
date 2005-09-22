Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVIVR5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVIVR5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVIVR5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:57:35 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41390 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbVIVR5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:57:34 -0400
Message-ID: <4332F085.9060909@pobox.com>
Date: Thu, 22 Sep 2005 13:57:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@suse.de>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>	 <20050922061849.GJ7929@suse.de>	 <1127398679.18840.84.camel@localhost.localdomain>	 <20050922135607.GK4262@suse.de> <1127399409.18840.95.camel@localhost.localdomain>
In-Reply-To: <1127399409.18840.95.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> SCSI suspend should not be blocking SATA suspend. If SCSI isn't with the
> program yet then SCSI should just not support suspend while allowing
> SATA to do so.

Jens' patch updates the SCSI layer -- as is proper and needed.

Someone needs to take Jens patch to linux-scsi as Christoph mentioned, 
maybe there is a change in the wind...

	Jeff


