Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWHJGN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWHJGN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWHJGN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:13:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14801 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161063AbWHJGN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:13:57 -0400
Message-ID: <44DACE9F.3090909@garzik.org>
Date: Thu, 10 Aug 2006 02:13:51 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain> <44DA4288.6020806@rtr.ca>
In-Reply-To: <44DA4288.6020806@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> This will also allow time for things like "udev" to perhaps think about
> an option to someday provide /dev/hd* symlinks for PATA devices when
> libata is used instead of IDE (?).  That might be a possible migration
> path in the far future.

Unfortunately a symlink won't work because of compatibility issues. 
/dev/hd supports more partitions, and a different set of ioctls.

	Jeff


