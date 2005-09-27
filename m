Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVI0VXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVI0VXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVI0VXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:23:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:20700 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750979AbVI0VXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:23:12 -0400
Message-ID: <4339B83C.9020103@pobox.com>
Date: Tue, 27 Sep 2005 17:23:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Grant Coady <grant_lkml@dodo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: cleanup: whitespace and remove unused
 entries
References: <937ti1hpvcjdk8hf894h651s81nu6il239@4ax.com> <20050926213557.GA21973@kroah.com>
In-Reply-To: <20050926213557.GA21973@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I don't think you need the change to the comments at the top of the
> file.

agreed.


> Also, I thought we wanted to keep all of the pci class ids, why did you
> delete them?  We should start by removing the pci device and vendor ids
> that are not currently used by the kernel, and then slowly move those
> ids into the individual drivers, starting with the device ids, and maybe
> eventually moving to the vendor ids.

The vendor ids are OBVIOUSLY common constants.  The proper place is 
where they live now:  pci_ids.h.

I see little value in moving referenced device ids into individual 
drivers, as they will make them harder to grep for, as time passes.

	Jeff


